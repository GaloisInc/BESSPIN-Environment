let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix {};
  mkShellClang = mkShell.override {stdenv=pkgs.clangStdenv;};
  riscv-openssh-freebsd = with besspin; callPackage ../misc/riscv-openssh.nix { riscv-gcc=riscv-gcc-freebsd; isFreeBSD=true; crossPrefix="riscv64-unknown-freebsd12.1";};
in mkShellClang {
  buildInputs = with pkgs; with besspin; [
    pkgsForRiscvClang.bmake
    riscv-clang
    qemu
    besspin.freebsdWorld.tools
    riscv-openssh-freebsd
  ];

  BESSPIN_TESTGEN_FREEBSD_IMAGE_QEMU = besspin.freebsdImageQemu;
  BESSPIN_TESTGEN_FREEBSD_IMAGE = besspin.freebsdImage;
  BESSPIN_TESTGEN_FREEBSD_DEBUG_IMAGE_QEMU = besspin.freebsdDebugImageQemu;
  BESSPIN_TESTGEN_FREEBSD_DEBUG_IMAGE = besspin.freebsdDebugImage;
  BESSPIN_TESTGEN_FREEBSD_WORLD = besspin.freebsdWorld;

  extraInputs = with besspin; [
    freebsdImageQemu
    freebsdImage
    freebsdDebugImageQemu
    freebsdDebugImage
  ];
}
