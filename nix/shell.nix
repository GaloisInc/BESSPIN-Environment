pkgs@{ callPackage, mkShell, qemu, which, netcat, socat, xxd, ps, expat, tcl, curl, dosfstools, libelf, lynx, zstd }:

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
    termcolor
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
    socat
    xxd
    ps
    curl
    libelf
    clafer
    fmtoolWrapper
    
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
  FETT_GFE_DEBIAN_FIRESIM = besspin.debianKernelFireSim;
  FETT_GFE_DEBIAN_ROOTFS_FIRESIM = besspin.debianRootfsFireSim;
  FETT_GFE_FREEBSD_FPGA = besspin.freebsdImage;
  FETT_GFE_FREEBSD_QEMU = besspin.freebsdImageQemu;
  FETT_GFE_FREEBSD_DEBUG_FPGA = besspin.freebsdDebugImage;
  FETT_GFE_FREEBSD_DEBUG_QEMU = besspin.freebsdDebugImageQemu;
  FETT_GFE_FREEBSD_CONNECTAL = besspin.freebsdElfConnectal;
  FETT_GFE_FREEBSD_ROOTFS_CONNECTAL = besspin.freebsdImageConnectal;
  FETT_GFE_BUSYBOX_FPGA = besspin.busyboxImage;
  FETT_GFE_BUSYBOX_QEMU = besspin.busyboxImageQemu;
  FETT_GFE_FREEBSD_SYSROOT = besspin.freebsdSysroot;
  BESSPIN_TESTGEN_PAM_DIR = besspin.riscv-libpam;
  BESSPIN_TESTGEN_KEYUTILS_DIR = besspin.riscv-libkeyutils;

  RISCV32_CLANG_BAREMETAL_SYSROOT = "${besspin.riscv32-clang-baremetal-sysroot}/riscv32-unknown-elf";
  RISCV64_CLANG_BAREMETAL_SYSROOT = "${besspin.riscv64-clang-baremetal-sysroot}/riscv64-unknown-elf";

  cachePackages = with besspin; [
    testingScripts
    netbootLoader
    debianImage
    debianImageQemu
    freebsdImage
    freebsdImageQemu
    freebsdDebugImage
    freebsdDebugImageQemu
    busyboxImage
    busyboxImageQemu
    riscv32-clang-baremetal-sysroot
    riscv64-clang-baremetal-sysroot
    debianKernelFireSim
    debianRootfsFireSim
    freebsdElfConnectal
    freebsdImageConnectal
  ];
  CPATH = with besspin; "${riscv-libkeyutils}/include:${riscv-libpam}/include";
}
