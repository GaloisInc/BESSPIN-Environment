pkgs@{ callPackage, mkShell, qemu, which, netcat, xxd, ps, tcl }:

let
  besspin = callPackage ./besspin-pkgs.nix {};

  fettPython3 = with besspin; python3Env.withPackages (ps: with ps; [
    requests
    pyserial
    pexpect
    configparser
    scapy
    tftpy
    psutil
  ]);

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
    
    testgenUnpacker
    tcl
  ];

  FETT_GFE_SCRIPT_DIR = "${besspin.testingScripts}/scripts";
  FETT_NETBOOT = besspin.netbootLoader;
  FETT_GFE_DEBIAN_FPGA = besspin.debianImage;
  FETT_GFE_DEBIAN_QEMU = besspin.testgenDebianImageQemu;
  FETT_GFE_FREEBSD_FPGA = besspin.freebsdImage;
  FETT_GFE_FREEBSD_QEMU = besspin.freebsdImageQemu;
  FETT_GFE_FREEBSD_DEBUG_FPGA = besspin.freebsdDebugImage;
  FETT_GFE_FREEBSD_DEBUG_QEMU = besspin.freebsdDebugImageQemu;
  FETT_GFE_BUSYBOX_FPGA = besspin.busyboxImage;
  FETT_GFE_BUSYBOX_QEMU = besspin.busyboxImageQemu;

  cachePackages = with besspin; [
    gfeSrc.modules."."
    netbootLoader
    debianImage
    testgenDebianImageQemu
    freebsdImage
    freebsdImageQemu
    freebsdDebugImage
    freebsdDebugImageQemu
    busyboxImage
    busyboxImageQemu
  ];
}
