{ mkShell, callPackage, path
, fetchFromGitHub
, bash, coreutils, gawk, python2, haskell, go, rWrapper, rPackages
, graphviz, alloy, pandoc, texlive
, binaryLevel ? 999
}:

let
  # Like `callPackage`, but may replace the package with a binary build
  # depending on the current `binaryLevel`.
  #
  #  * `binaryLevel < myLevel` means we want to use the source package as usual.
  #  * `binaryLevel > myLevel` means we want to use the binary build instead.
  #  * `binaryLevel == myLevel` means we are currently building the binary
  #    version of this package.  We build the package from source (as when
  #    `binaryLevel < myLevel`), but also print the output path so the user can
  #    copy it into the repository of binary builds.
  #
  # This scheme of multiple "binary levels" is necessary because a package
  # copied from a binary build has a different hash than a package compiled
  # from source, and that hash is often hardcoded into downstream package
  # outputs, including ones that themselves may require binary builds.
  callPackageBin = myLevel: path: args:
    if binaryLevel < myLevel then
      callPackage path args
    else if binaryLevel > myLevel then
      callPackage ./get-binary.nix { orig = callPackage path args; }
    else
      let pkg = callPackage path args;
      in builtins.trace "built package for binary: ${pkg}" pkg;


  binWrapper = callPackage ./bin-wrapper.nix {};
  unpacker = callPackage ./unpacker.nix {};
  mkGoPath = callPackage go/gopath.nix {};


  # "Major" dependencies.  These are language interpreters/compilers along with
  # sets of libraries.

  # HACK: For python, we actually use the packages from a newer release of
  # nixpkgs, since some important python3.7 packages are broken in the nixpkgs
  # revision we're using for everything else.  Eventually, we should migrate
  # entirely to the newer nixpkgs, and get rid of this special case.
  pkgs_19_03 = import ./pinned-pkgs.nix {
    pkgs = { inherit fetchFromGitHub; };
    jsonPath = ./nixpkgs-19.03.json;
  };

  pythonEnv = pkgs_19_03.python37;
  python3 = pythonEnv;

  haskellEnv = haskell.packages.ghc844.override {
    overrides = self: super: {
      # Clafer dependencies.  The default versions from nixpkgs don't build
      # successfully on this GHC version.
      data-stringmap = self.callPackage haskell/data-stringmap-1.0.1.1.nix {};
      json-builder = self.callPackage haskell/json-builder-0.3-for-ghc84.nix {};
      toml-parser = self.callPackage haskell/toml-parser-0.1.0.0.nix {};
      clafer_0_4_5 = self.callPackage haskell/clafer-0.4.5.nix {};
      clafer_0_5_0 = self.callPackage haskell/clafer-0.5.0.nix {};
    };
  };
  ghc = haskellEnv.ghc;

  goPath = mkGoPath {
    "gitlab.com/ashay/bagpipe" = callPackage go/bagpipe.nix {};
  };

  rEnv = rWrapper.override {
    packages = with rPackages; [
      ggplot2
      reshape2
      geometry
      Matrix
    ];
  };

  racketEnv = callPackage racket/racket-env.nix {};

  texliveEnv = texlive.combine { inherit (texlive) scheme-medium; };


  # Other dependencies - binaries and C/C++ libraries.

  verific_2018_06 = callPackage cxx/verific.nix {
    version = "2018-06";
    rev = "71ecf0524b1084ac55368cd8881b864ec7092c69";
  };
  verific = callPackage cxx/verific.nix {};

  tinycbor = callPackage cxx/tinycbor.nix {};

  # Csmith, built from the galois `bof` branch.
  csmith-bof = callPackage cxx/csmith.nix {};

  # These riscv-arch values are taken from the coremark -march flags for P1/P2
  riscv-gcc = callPackage misc/riscv-gcc.nix { riscv-arch = "rv32imac"; };
  riscv-gcc-64 = callPackage misc/riscv-gcc.nix { riscv-arch = "rv64imafdc"; };

  riscv-openocd = callPackage misc/riscv-openocd.nix {};

  alloy-check = callPackage misc/alloy-check.nix {};


  # BESSPIN tool suite components.

  configurator = callPackage besspin/configurator.nix {};
  configuratorWrapper = binWrapper besspin/besspin-configurator {
    inherit bash;
    python3 = pythonEnv.withPackages (ps: with ps; [ flask ]);
    clafer = haskellEnv.clafer_0_5_0;
    inherit configurator;
  };

  halcyon = callPackageBin 1 besspin/halcyon.nix {
    # Halcyon uses the `PrettyPrintXML` function, which was removed after the
    # June 2018 release of Verific.
    verific = verific_2018_06;
  };

  bofgen = callPackage besspin/bofgen.nix { inherit csmith-bof; };
  bofgenWrapper = binWrapper besspin/besspin-bofgen { inherit bash python3 bofgen; };

  testgenSrc = callPackage besspin/testgen-src.nix {};
  testgenHarnessUnpacker = unpacker {
    baseName = "bof-test-harness";
    longName = "BESSPIN buffer overflow test harness";
    version = "0.1-${builtins.substring 0 7 testgenSrc.rev}";
    pkg = "${testgenSrc}/harness";
  };

  riscvTimingTests = callPackage besspin/riscv-timing-tests.nix {
    inherit goPath;
  };
  rvttSrc = callPackage besspin/riscv-timing-tests-src.nix {};
  rvttPlotInt = binWrapper besspin/besspin-timing-plot-int {
    inherit bash rEnv rvttSrc;
  };
  rvttInterpolate = binWrapper besspin/besspin-timing-interpolate {
    inherit bash rEnv rvttSrc;
  };
  rvttUnpacker = unpacker {
    baseName = "timing-test-src";
    longName = "BESSPIN RISC-V timing test source code";
    version = "0.1-${builtins.substring 0 7 rvttSrc.rev}";
    pkg = "${rvttSrc}/src";
  };

  aeSrc = callPackage besspin/arch-extract-src.nix {};
  aeDriver = callPackage besspin/arch-extract-driver.nix {
    inherit haskellEnv;
  };
  aeExportVerilog = callPackageBin 1 besspin/arch-extract-export-verilog.nix {
    inherit verific tinycbor;
  };
  aeDriverWrapper = binWrapper besspin/besspin-arch-extract {
    inherit bash aeDriver aeExportVerilog;
  };

  featuresynth = callPackage besspin/featuresynth.nix {};
  featuresynthWrapper = binWrapper besspin/besspin-feature-extract {
    inherit bash featuresynth;
    racket = racketEnv.withPackages (ps: with ps; [ rosette toml ]);
  };

  coremarkSrc = callPackage besspin/coremark-src.nix {};
  coremarkP1 = callPackage besspin/coremark.nix {
    riscv-gcc = riscv-gcc;
    gfe-target = "P1";
  };
  coremarkP2 = callPackage besspin/coremark.nix {
    riscv-gcc = riscv-gcc-64;
    gfe-target = "P2";
  };
  coremarkBuilds = callPackage besspin/coremark-builds.nix {
    inherit coremarkP1 coremarkP2;
  };
  coremarkSrcUnpacker = unpacker {
    baseName = "coremark-src";
    longName = "CoreMark source code";
    version = "0.1-${builtins.substring 0 7 coremarkSrc.rev}";
    pkg = "${coremarkSrc}";
  };
  coremarkBuildsUnpacker = unpacker {
    baseName = "coremark-builds";
    longName = "CoreMark binary builds";
    version = "0.1-${builtins.substring 0 7 coremarkSrc.rev}";
    pkg = "${coremarkBuilds}";
  };

  buildPiccolo = binWrapper besspin/besspin-build-configured-piccolo {
    inherit bash coreutils gawk python3;
    clafer = haskellEnv.clafer_0_5_0;
    inherit alloy-check aeSrc;
  };

  mibenchSrc = callPackage besspin/mibench-src.nix {};
  mibenchP1 = callPackage besspin/mibench.nix {
    riscv-gcc = riscv-gcc;
    gfe-target = "P1";
  };
  mibenchP2 = callPackage besspin/mibench.nix {
    riscv-gcc = riscv-gcc-64;
    gfe-target = "P2";
    # TODO: figure out why these two produce linker errors, and fix them
    skip-benches = [ "basicmath" "fft" ];
  };
  mibenchBuilds = callPackage besspin/mibench-builds.nix {
    inherit mibenchP1 mibenchP2;
  };
  mibenchSrcUnpacker = unpacker {
    baseName = "mibench-src";
    longName = "MiBench2 source code";
    version = "0.1-${builtins.substring 0 7 mibenchSrc.rev}";
    pkg = "${mibenchSrc}";
  };
  mibenchBuildsUnpacker = unpacker {
    baseName = "mibench-builds";
    longName = "MiBench2 binary builds";
    version = "0.1-${builtins.substring 0 7 mibenchSrc.rev}";
    pkg = "${mibenchBuilds}";
  };

  pocExploits = callPackage besspin/poc-exploits.nix { inherit texliveEnv; };
  pocExploitsUnpacker = unpacker {
    baseName = "poc-exploits";
    longName = "proof-of-concept exploit documentation and code";
    version = "0.1-${builtins.substring 0 7 pocExploits.src.rev}";
    pkg = "${pocExploits}";
  };


in mkShell {
  buildInputs = [
    (pythonEnv.withPackages (ps: with ps; [
      # Used by the configurator
      flask
      # Used by bofgen test harness
      matplotlib
    ]))

    (python2.withPackages (ps: with ps; [
      # Dependencies of gfe's run_elf.py
      pyserial pexpect
    ]))

    (haskellEnv.clafer_0_5_0)

    rEnv

    (racketEnv.withPackages (ps: with ps; [
      rosette toml
    ]))

    go
    # Also see GOPATH environment setting below

    riscv-gcc
    riscv-gcc-64
    riscv-openocd

    graphviz
    alloy
    alloy-check
    # We use the normal `pandoc` instead of `haskellEnv.pandoc` because the
    # normal one will be available from the NixOS binary caches.
    pandoc
    texliveEnv

    configuratorWrapper
    halcyon
    bofgenWrapper
    testgenHarnessUnpacker
    riscvTimingTests
    rvttPlotInt
    rvttInterpolate
    rvttUnpacker
    aeDriverWrapper
    featuresynthWrapper
    coremarkSrcUnpacker
    coremarkBuildsUnpacker
    buildPiccolo
    mibenchSrcUnpacker
    mibenchBuildsUnpacker
    pocExploitsUnpacker
  ];

  GOPATH = goPath;

  nixpkgs = path;
}

