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

  KERNEL_FPGA = besspin.freebsdKernelFpga;
  KERNEL_QEMU = besspin.freebsdKernelQemu;

  IMAGE_QEMU = besspin.testgenFreebsdImageQemu;
  IMAGE_FPGA = besspin.freebsdImage;
}
