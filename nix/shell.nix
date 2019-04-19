pkgs@{ mkShell, callPackage, path
, go, graphviz, alloy, pandoc, openssl
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

    go
    # Also see GOPATH environment setting below

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
    openssl

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

    programFpgaWrapper
    runElf
  ];

  GOPATH = besspin.goPath;

  nixpkgs = path;

  # -Werror=format-security causes problems for some HOSTCC parts of the
  # binutils build
  hardeningDisable = [ "format" ];
}

