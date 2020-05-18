pkgs@{ callPackage, mkShell, qemu, which, netcat, xxd, ps, expat, tcl }:

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
    pynacl
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

    # For building Voting system
    expat
  ];

  FETT_GFE_SCRIPT_DIR = "${besspin.testingScripts}/scripts";
  FETT_GFE_BITFILE_DIR = "${besspin.programFpga}/bitstreams";
  FETT_NETBOOT = besspin.netbootLoader;
  FETT_GFE_DEBIAN_FPGA = besspin.debianImage;
  FETT_GFE_DEBIAN_QEMU = besspin.testgenDebianImageQemu;
  FETT_GFE_FREEBSD_FPGA = besspin.freebsdImage;
  FETT_GFE_FREEBSD_QEMU = besspin.freebsdImageQemu;
  FETT_GFE_BUSYBOX_FPGA = besspin.busyboxImage;
  FETT_GFE_BUSYBOX_QEMU = besspin.busyboxImageQemu;

  cachePackages = with besspin; [
    testingScripts
    gfeSrc
    netbootLoader
    debianImage
    testgenDebianImageQemu
    freebsdImage
    freebsdImageQemu
    busyboxImage
    busyboxImageQemu
  ];
}
