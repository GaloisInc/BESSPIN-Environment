pkgs@{ mkShell, callPackage, path
, jre, go, graphviz, alloy, pandoc, openssl
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

    # needed for verilator simulator builds
    # XXX glibc must come before glibc.static, otherwise all dynamic binaries
    # built by gcc will segfault on startup!  Likely related to
    # https://github.com/NixOS/nixpkgs/issues/59267
    glibc glibc.static

    # RISCV toolchain
    riscv-gcc
    riscv-gcc-64
    riscv-gcc-64-linux
    # run_elf.py requires openocd in $PATH
    riscv-openocd

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
}

