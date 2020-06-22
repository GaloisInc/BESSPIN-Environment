pkgs@{ callPackage, mkShell, qemu, which, netcat, xxd, ps, expat, tcl, curl, dosfstools, lynx, zstd }:

let
  besspin = callPackage ./besspin-pkgs.nix {};

  fettPython3 = (with besspin; python3Env.withPackages (ps: with ps; [
    requests
    pyserial
    pexpect
    configparser
    scapy
    tftpy
    psutil
    pynacl
    boto3
    zstandard
  ])).override(args: { ignoreCollisions = true; });

in mkShell {
  buildInputs = with besspin; with pkgs; [
    # RISCV toolchain
    riscv-gcc
    riscv-gcc-linux
    riscv-gcc-freebsd
    riscv-libkeyutils
    riscv-libpam
    riscv-llvm
    riscv-clang
    riscv-lld

    # User-facing GFE functions. See also gfe.nix
    programFpgaWrapper
    clearFlashWrapper
    runElf

    # testgen dependencies
    fettPython3
    qemu
    riscv-libpam
    riscv-libkeyutils
    riscv-openocd
    which
    netcat
    xxd
    ps
    curl
    
    testgenUnpacker
    tcl
    dosfstools
    lynx
    zstd

    # For building Voting system
    expat
  ];

  FETT_GFE_SCRIPT_DIR = "${besspin.testingScripts}/scripts";
  FETT_GFE_BITFILE_DIR = "${besspin.programFpga}/bitstreams";
  FETT_NETBOOT = besspin.netbootLoader;
  FETT_GFE_DEBIAN_FPGA = besspin.debianImage;
  FETT_GFE_DEBIAN_QEMU = besspin.debianImageQemu;
  FETT_GFE_DEBIAN_FIRESIM = besspin.debianImageFireSim;
  FETT_GFE_FREEBSD_FPGA = besspin.freebsdImage;
  FETT_GFE_FREEBSD_QEMU = besspin.freebsdImageQemu;
  FETT_GFE_FREEBSD_DEBUG_FPGA = besspin.freebsdDebugImage;
  FETT_GFE_FREEBSD_DEBUG_QEMU = besspin.freebsdDebugImageQemu;
  FETT_GFE_BUSYBOX_FPGA = besspin.busyboxImage;
  FETT_GFE_BUSYBOX_QEMU = besspin.busyboxImageQemu;
  FETT_GFE_FREEBSD_SYSROOT = besspin.freebsdSysroot;

  RISCV32_CLANG_BAREMETAL_SYSROOT = "${besspin.riscv32-clang-baremetal-sysroot}/riscv32-unknown-elf";
  RISCV64_CLANG_BAREMETAL_SYSROOT = "${besspin.riscv64-clang-baremetal-sysroot}/riscv64-unknown-elf";

  cachePackages = with besspin; [
    testingScripts
    netbootLoader
    debianImage
    debianImageQemu
    debianImageFireSim
    freebsdImage
    freebsdImageQemu
    freebsdDebugImage
    freebsdDebugImageQemu
    busyboxImage
    busyboxImageQemu
    riscv32-clang-baremetal-sysroot
    riscv64-clang-baremetal-sysroot
  ];
}
