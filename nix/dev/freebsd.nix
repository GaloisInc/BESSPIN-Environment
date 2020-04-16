let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix {};
  mkShellClang = mkShell.override {stdenv=pkgs.clangStdenv;};
in mkShellClang {
  buildInputs = with pkgs; with besspin; [
    pkgsForRiscvClang.bmake
    riscv-clang
    qemu
    besspin.freebsdWorld.tools
  ];

  BESSPIN_TESTGEN_FREEBSD_IMAGE_QEMU = besspin.freebsdImageQemu;
  BESSPIN_TESTGEN_FREEBSD_IMAGE = besspin.freebsdImage;
  BESSPIN_TESTGEN_FREEBSD_DEBUG_IMAGE_QEMU = besspin.freebsdDebugImageQemu;
  BESSPIN_TESTGEN_FREEBSD_DEBUG_IMAGE = besspin.freebsdDebugImage;

  extraInputs = with besspin; [
    freebsdImageQemu
    freebsdImage
    freebsdDebugImageQemu
    freebsdDebugImage
  ];
}
