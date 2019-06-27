{}:

let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix { binaryLevel = 0; };

in mkShell {
  buildInputs = with pkgs; with besspin; [
    # When adding a package here, consider whether it
    # should also be added to ../shell.nix.

    # for run_elf.py
    python2

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

    testingScripts
    programFpgaWrapper
    runElf
    verilator

    # used for verification of the voting system demonstrator
    framac
  ];

  nixpkgs = pkgs.path;

  # -Werror=format-security causes problems for some HOSTCC parts of the
  # binutils build
  hardeningDisable = [ "format" ];

  # Used by the verilator simulator builds
  GLIBC_STATIC = pkgs.glibc.static;
}
