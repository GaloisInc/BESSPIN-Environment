pkgs@{ mkShell, callPackage, path
, jre, go, graphviz, alloy, pandoc, openssl, bc, bison, flex, glibc, verilator
, binaryLevel ? 999
}:

let
  besspin = callPackage ./besspin-pkgs.nix { inherit binaryLevel; };

in mkShell {
  buildInputs = with besspin; [
    python2
    python3
    (haskellEnv.clafer_0_5_0)
    rEnv
    racket
    sbt
    go

    # RISCV toolchain
    riscv-gcc
    riscv-gcc-64
    riscv-gcc-64-linux
    riscv-llvm
    riscv-clang
    # run_elf.py requires openocd in $PATH
    riscv-openocd

    verilator

    graphviz
    alloy
    alloy-check
    # We use the normal `pandoc` instead of `haskellEnv.pandoc` because the
    # normal one will be available from the NixOS binary caches.
    pandoc
    texliveEnv

    # Used for riscv-linux build
    openssl bc bison flex

    # Deps of rocket-chip build process
    jre
    scalaEnv.scala
    rocketChipBuildUnpacker

    configuratorWrapper
    halcyon
    halcyonBoomUnpacker
    bofgenWrapper
    testgenHarnessUnpacker
    riscvTimingTests
    rvttPlotInt
    rvttInterpolate
    rvttUnpacker
    aeDriverWrapper
    featuresynthWrapper
    fmtoolWrapper
    rocketChipHelper
    coremarkSrcUnpacker
    coremarkBuildsUnpacker
    buildPiccolo
    mibenchSrcUnpacker
    mibenchBuildsUnpacker
    pocExploitsUnpacker

    # User-facing GFE functions. See also dev/gfe.nix.
    programFpgaWrapper
    runElf
  ];

  nixpkgs = path;

  # -Werror=format-security causes problems for some HOSTCC parts of the
  # binutils build
  hardeningDisable = [ "format" ];

  # Used by the verilator simulator builds
  GLIBC_STATIC = pkgs.glibc.static;
}

