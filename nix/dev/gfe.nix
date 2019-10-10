{}:

let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix {};

in mkShell {
  buildInputs = with pkgs; with besspin; [
    # When adding a package here, consider whether it
    # should also be added to ../shell.nix.

    # RISCV toolchain
    riscv-gcc
    riscv-gcc-64
    riscv-gcc-64-linux
    riscv-llvm
    riscv-clang
    # run_elf.py requires openocd in $PATH
    riscv-openocd

    # Used for riscv-linux build
    openssl bc bison flex

    # Used for riscv debian build
    debootstrap
    proot
    fakeroot
    dpkg
    qemu

    testingScripts
    programFpgaWrapper
    runElf
    verilator

    #used for testgen
    simulatorBinBSV1
    simulatorBinCHSL1
    simulatorBinBSV2
    simulatorBinCHSL2
    simulatorElfToHex
    qemu
    python3
  ];

  nixpkgs = pkgs.path;

  # -Werror=format-security causes problems for some HOSTCC parts of the
  # binutils build
  hardeningDisable = [ "format" ];

  # Used by the verilator simulator builds
  GLIBC_STATIC = pkgs.glibc.static;

  DEBIAN_PORTS_ARCHIVE_KEYRING =
    "${besspin.debianPortsArchiveKeyring}/share/keyrings/debian-ports-archive-keyring.gpg";
}
