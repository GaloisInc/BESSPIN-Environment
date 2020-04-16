let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage lib;
  besspin = callPackage ../besspin-pkgs.nix {};

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
    python3
    qemu
    riscv-libpam
    riscv-libkeyutils
    riscv-openocd
    which
    netcat
    xxd
    ps
    
    testgenUnpacker
  ];

  FETT_GFE_DEBIAN_FPGA = besspin.debianImage;
  FETT_GFE_DEBIAN_QEMU = besspin.testgenDebianImageQemu;
  FETT_GFE_FREEBSD_FPGA = besspin.freebsdImage;
  FETT_GFE_FREEBSD_QEMU = besspin.freebsdImageQemu;
}
