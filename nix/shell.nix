{ mkShell, callPackage, path
, bash, python37, haskell, go, rWrapper, rPackages
, graphviz, alloy
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

  # Customized Python 3.7 environment with BESSPIN dependencies installed.
  pythonEnv = (python37.override {
    packageOverrides = self: super: {
      # `hypothesis` test suite currently fails
      hypothesis = super.hypothesis.overridePythonAttrs (old: { doCheck = false; });
    };
  });
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


  # Other dependencies - binaries and C/C++ libraries.

  verific_2018_06 = callPackage cxx/verific.nix {
    version = "2018-06";
    rev = "71ecf0524b1084ac55368cd8881b864ec7092c69";
  };
  verific = callPackage cxx/verific.nix {};

  tinycbor = callPackage cxx/tinycbor.nix {};

  # Csmith, built from the galois `bof` branch.
  csmith-bof = callPackage cxx/csmith.nix {};

  riscv-gcc = callPackage misc/riscv-gcc.nix {};
  # Note: this value for riscv-arch was chosen arbitrarily, and may not be the
  # most useful option.
  riscv-gcc-64 = callPackage misc/riscv-gcc.nix { riscv-arch = "rv64imac"; };

  alloy-check = callPackage misc/alloy-check.nix {};


  # BESSPIN tool suite components.

  configurator = callPackage besspin/configurator.nix {};
  configuratorWrapper = binWrapper besspin/besspin-configurator {
    inherit bash;
    python3 = pythonEnv.withPackages (ps: with ps; [ flask ]);
    clafer = haskellEnv.clafer_0_4_5;
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



in mkShell {
  buildInputs = [
    (pythonEnv.withPackages (ps: with ps; [
      flask
    ]))

    (haskellEnv.clafer_0_4_5)

    rEnv

    (racketEnv.withPackages (ps: with ps; [
      rosette toml
    ]))

    go
    # Also see GOPATH environment setting below

    riscv-gcc
    riscv-gcc-64

    graphviz
    alloy
    alloy-check

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
  ];

  GOPATH = goPath;

  nixpkgs = path;
}

