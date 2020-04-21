let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage lib;
  besspin = callPackage ../besspin-pkgs.nix {};

  # We don't want to modify the pythone environment in
  # besspin-pkgs.nix, since doing that will cause a bunch of packages
  # to rebuild.
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

  FETT_NETBOOT = besspin.netbootLoader;
  FETT_GFE_DEBIAN_FPGA = besspin.debianImage;
  FETT_GFE_DEBIAN_QEMU = besspin.testgenDebianImageQemu;
  FETT_GFE_FREEBSD_FPGA = besspin.freebsdImage;
  FETT_GFE_FREEBSD_QEMU = besspin.freebsdImageQemu;
  FETT_GFE_BUSYBOX_FPGA = besspin.busyboxImage;
  FETT_GFE_BUSYBOX_QEMU = besspin.busyboxImageQemu;
}
