pkgs@{ mkShell, callPackage, path
, jre, go, graphviz, alloy, pandoc, openssl, bc, bison, flex, glibc, verilator
, qemu, which, netcat, glibcLocales
}:

let
  besspin = callPackage ./besspin-pkgs.nix {};

in mkShell {
  buildInputs = with besspin; [
    python3
    rEnv
    racket
    sbt
    go

    # RISCV toolchain
    riscv-gcc
    riscv-gcc-linux
    riscv-llvm
    riscv-clang
    # run_elf.py requires openocd in $PATH
    riscv-openocd

    verilator

    graphviz
    alloy
    alloy-check
    clafer
    # We use the normal `pandoc` instead of `haskellEnv.pandoc` because the
    # normal one will be available from the NixOS binary caches.
    pandoc

    # Used for riscv-linux build
    openssl bc bison flex

    cheri-qemu

    # Deps of rocket-chip build process
    jre
    scalaEnv.scala
    rocketChipBuildUnpacker

    configuratorWrapper
    halcyon
    halcyonBoomUnpacker

    testgenUnpacker

    riscvTimingTests
    rvttPlotInt
    rvttInterpolate
    rvttUnpacker

    aeDriverWrapper
    featuresynthWrapper
    fmtoolWrapper
    rocketChipHelper
    boomHelper
    rocketChipCheckConfigWrapper
    # Needed for now, as there arch-extract can't export firrtl on its own yet
    aeExportFirrtl

    coremarkSrcUnpacker
    coremarkBuildsUnpacker
    buildPiccolo
    mibenchSrcUnpacker
    mibenchBuildsUnpacker
    pocExploitsUnpacker

    # User-facing GFE functions. See also dev/gfe.nix.
    programFpgaWrapper
    runElf


    # testgen dependencies
    python3
    qemu

    riscv-gcc
    riscv-gcc-linux
    riscv-llvm
    riscv-clang
    riscv-lld
    riscv-openocd

    programFpgaWrapper
    runElf
    verilator
    riscvTestsBuildUnpacker

    simulatorBins

    which
    netcat

    # Haskell programs fail to read UTF-8 inputs when locales are not
    # installed, or when using a non-UTF-8 locale.
    glibcLocales
  ];

  LANG = "en_US.UTF-8";

  nixpkgs = path;

  # -Werror=format-security causes problems for some HOSTCC parts of the
  # binutils build
  hardeningDisable = [ "format" ];


  # Used by the verilator simulator builds
  GLIBC_STATIC = pkgs.glibc.static;

  inherit (besspin) debianRepoSnapshot;

  # More packages used by testgen
  BESSPIN_TESTGEN_BUSYBOX_IMAGE_QEMU = besspin.busyboxImageQemu;
  BESSPIN_TESTGEN_BUSYBOX_IMAGE = besspin.busyboxImage;
  BESSPIN_TESTGEN_DEBIAN_IMAGE_QEMU = besspin.testgenDebianImageQemu;
  BESSPIN_TESTGEN_DEBIAN_IMAGE = besspin.debianImage;
  BESSPIN_GFE_SCRIPT_DIR = "${besspin.testingScripts}/scripts";

  # Convenient list of packages referenced in the above environment variables,
  # used to simplify deployment.
  extraInputs = with besspin; [
    pkgs.glibc.static
    debianRepoSnapshot
    busyboxImageQemu
    busyboxImage
    testgenDebianImageQemu
    debianImage
    testingScripts
  ];

  passthru = { inherit besspin; };
}

