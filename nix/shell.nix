pkgs@{ mkShell, callPackage, path
, go , graphviz, alloy, pandoc
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
}

