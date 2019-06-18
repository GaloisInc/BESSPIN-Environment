{}:

let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix { binaryLevel = 0; };

in mkShell {
  buildInputs = with pkgs; with besspin; [
    # When adding a package here, consider whether it
    # should also be added to ../shell.nix.

    # needed for verilator simulator builds
    # XXX glibc must come before glibc.static, otherwise all dynamic binaries
    # built by gcc will segfault on startup!  Likely related to
    # https://github.com/NixOS/nixpkgs/issues/59267
    glibc glibc.static

    # for run_elf.py
    python2

    # RISCV toolchain
    riscv-gcc
    riscv-gcc-64
    riscv-gcc-64-linux
    # run_elf.py requires openocd in $PATH
    riscv-openocd

    # Used for riscv-linux build
    openssl bc bison flex

    testingScripts
    programFpgaWrapper
    runElf
  ];

  nixpkgs = pkgs.path;

  # -Werror=format-security causes problems for some HOSTCC parts of the
  # binutils build
  hardeningDisable = [ "format" ];
}
