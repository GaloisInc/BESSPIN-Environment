pkgs@{ callPackage
, bash, coreutils, gawk, go, python27, python37, haskell, rWrapper, rPackages
, texlive, jre
, binaryLevel ? 999
}:

rec {
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

  callPackageForRiscvClang = (import ./pinned-pkgs.nix {
    jsonPath = ./nixpkgs-for-riscv-clang.json;
  }).callPackage;

  binWrapper = callPackage ./bin-wrapper.nix {};
  unpacker = callPackage ./unpacker.nix {};
  unpackerGfe = callPackage ./unpacker.nix { prefix = "gfe"; };


  # "Major" dependencies.  These are language interpreters/compilers along with
  # sets of libraries.
  #
  # In general, we try to use the same env across all packages and wrapper
  # scripts.  This way, when the user runs `python3` (for example) inside the
  # nix-shell, the packages they see are the same ones that are available
  # within the various wrapper scripts.

  python3Env = python37.override {
    packageOverrides = self: super: {
      cbor2 = self.callPackage python/cbor2.nix {};
    };
  };
  python3 = python3Env.withPackages (ps: with ps; [
    # Used by the configurator
    flask
    # Used by bofgen test harness
    matplotlib
    # Useful for arch-extract testing/debugging
    cbor2
  ]);

  python2 = python27.withPackages (ps: with ps; [
    # Dependencies of gfe's run_elf.py
    pyserial pexpect
  ]);

  haskellEnv = haskell.packages.ghc844.override {
    overrides = self: super: {
      # Clafer dependencies.  The default versions from nixpkgs don't build
      # successfully on this GHC version.
      data-stringmap = self.callPackage haskell/data-stringmap-1.0.1.1.nix {};
      json-builder = self.callPackage haskell/json-builder-0.3-for-ghc84.nix {};
      clafer_0_4_5 = self.callPackage haskell/clafer-0.4.5.nix {};
      clafer_0_5_0 = self.callPackage haskell/clafer-0.5.0.nix {};
      clafer_0_5_besspin = self.callPackage haskell/clafer-0.5-besspin.nix {};
    };
  };
  ghc = haskellEnv.ghc;

  rEnv = rWrapper.override {
    packages = with rPackages; [
      ggplot2
      reshape2
      geometry
      Matrix
    ];
  };

  racketEnv = callPackage racket/racket-env.nix {};
  racket = racketEnv.withPackages (ps: with ps; [
    rosette toml bdd threading-lib
  ]);

  texliveEnv = texlive.combine { inherit (texlive) scheme-medium; };

  scalaEnv = callPackage scala/scala-env.nix {
    overrides = self: super: {
      rocket-chip-config-plugin = self.callPackage besspin/rocket-chip-config-plugin.nix {};
    };
  };
  sbt = scalaEnv.withPackages (ps: with ps; [
    chisel3 firrtl hardfloat
    rocket-chip
    rocket-chip-config-plugin
    binDeps.chisel3-firrtl-hardfloat
    binDeps.rocket-chip
    binDeps.borer
  ]);


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
  riscv-gcc-64-linux = callPackage misc/riscv-gcc.nix {
    riscv-arch = "rv64imafdc";
    targetLinux = true;
  };

  riscvLlvmPackages = callPackageForRiscvClang misc/riscv-clang.nix {};
  riscv-llvm = riscvLlvmPackages.llvm;
  riscv-clang = riscvLlvmPackages.clang;

  riscv-openocd = callPackage misc/riscv-openocd.nix {};

  alloy-check = callPackage misc/alloy-check.nix {};

  nametag = callPackage misc/nametag.nix {};


  # BESSPIN tool suite components.

  configurator = callPackage besspin/configurator.nix {};
  configuratorWrapper = binWrapper besspin/besspin-configurator {
    inherit bash python3;
    clafer = haskellEnv.clafer_0_5_0;
    inherit configurator;
  };

  halcyon = callPackageBin 1 besspin/halcyon.nix {
    # Halcyon uses the `PrettyPrintXML` function, which was removed after the
    # June 2018 release of Verific.
    verific = verific_2018_06;
  };
  halcyonSrc = callPackage besspin/halcyon-src.nix {};

  bofgen = callPackage besspin/bofgen.nix { inherit csmith-bof; };
  bofgenWrapper = binWrapper besspin/besspin-bofgen { inherit bash python3 bofgen; };

  testgenSrc = callPackage besspin/testgen-src.nix {};
  testgenHarnessUnpacker = unpacker {
    baseName = "bof-test-harness";
    longName = "BESSPIN buffer overflow test harness";
    version = "0.1-${builtins.substring 0 7 testgenSrc.rev}";
    pkg = "${testgenSrc}/harness";
  };

  fesvr = callPackage misc/fesvr.nix {};
  riscvTimingTests = callPackage besspin/riscv-timing-tests.nix {};
  rvttSrc = callPackage besspin/riscv-timing-tests-src.nix {};
  rvttEnv = callPackage besspin/riscv-timing-tests-env.nix {
    inherit fesvr;
  };
  rvttPlotInt = binWrapper besspin/besspin-timing-plot-int {
    inherit bash rEnv rvttSrc;
  };
  rvttPlotFloat = binWrapper besspin/besspin-timing-plot-float {
    inherit bash rEnv rvttSrc;
  };
  rvttInterpolate = binWrapper besspin/besspin-timing-interpolate {
    inherit bash rEnv rvttSrc;
  };
  rvttUnpacker = unpacker {
    baseName = "timing-tests";
    longName = "BESSPIN RISC-V timing test source code";
    version = "0.1-${builtins.substring 0 7 rvttSrc.rev}";
    pkg = "${rvttEnv}";
  };

  aeSrc = callPackage besspin/arch-extract-src.nix {};
  aeDriver = callPackage besspin/arch-extract-driver.nix {
    inherit haskellEnv;
  };
  aeExportVerilog = callPackageBin 1 besspin/arch-extract-export-verilog.nix {
    inherit verific tinycbor;
  };
  firrtlExport = callPackage besspin/firrtl-export.nix {
    inherit scalaEnv;
  };
  aeExportFirrtl = binWrapper besspin/besspin-arch-extract-export-firrtl {
    inherit bash jre firrtlExport;
  };
  aeDriverWrapper = binWrapper besspin/besspin-arch-extract {
    inherit bash aeDriver aeExportVerilog;
  };

  featuresynth = callPackage besspin/featuresynth.nix {};
  featuresynthWrapper = binWrapper besspin/besspin-feature-extract {
    inherit bash featuresynth racket;
  };
  fmtoolWrapper = binWrapper besspin/besspin-feature-model-tool {
    inherit bash featuresynth racket;
  };
  rocketChipConfigs = scalaEnv.callPackage besspin/rocket-chip-configs.nix {};

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

  halcyonBoomUnpacker = unpacker {
    baseName = "halcyon-boom-verilog";
    longName = "prebuilt BOOM Verilog for use with Halcyon";
    version = "0.1-${builtins.substring 0 7 halcyonSrc.rev}";
    pkg = "${halcyonSrc}/processors/boom";
  };

  rocketChipBuildUnpacker = unpackerGfe {
    baseName = "rocket-chip-build";
    longName = "simple rocket-chip elaboration setup";
    version = "0.1";
    pkg = ../scripts/rocket-chip-build;
  };


  gfeSrc = callPackage gfe/gfe-src.nix {};

  programFpga = callPackage gfe/program-fpga.nix { inherit riscv-openocd; };
  programFpgaWrapper = binWrapper gfe/gfe-program-fpga {
    inherit bash programFpga;
  };

  testingScripts = callPackage gfe/testing-scripts.nix {};
  runElf = binWrapper gfe/gfe-run-elf {
    inherit bash python2 testingScripts;
  };
}
