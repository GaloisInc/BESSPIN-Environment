let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix {};
  mkShellClang = mkShell.override {stdenv=pkgs.clangStdenv;};
in mkShellClang {
  buildInputs = with pkgs; with besspin; [
    pkgsForRiscvClang.bmake
    libarchive
    which
    python3
    hostname
    zlib

    riscv-clang


    besspin.freebsdWorld.tools
  ];

  KERNEL_FPGA = besspin.freebsdKernelFpga;
  KERNEL_QEMU = besspin.freebsdKernelQemu;

  XCC = "${besspin.riscv-clang}/bin/clang";
  XCXX = "${besspin.riscv-clang}/bin/clang++";
  XCPP = "${besspin.riscv-clang}/bin/clang-cpp";
  XLD = "${besspin.riscv-lld}/bin/ld.lld";
  XOBJDUMP = "${besspin.riscv-llvm}/bin/llvm-objdump";
  XOBJCOPY = "${besspin.riscv-llvm}/bin/llvm-objcopy";
  XCFLAGS = "-fuse-ld=${besspin.riscv-lld}/bin/ld.lld -Qunused-arguments";
  MAKEOBJDIRPREFIX="$PWD/obj";

  bmakeFlags = [
    "-DDB_FROM_SRC"
    "-DNO_ROOT"
    "-DBUILD_WITH_STRICT_TMPPATH"
    "TARGET=riscv"
    "TARGET_ARCH=riscv64"
    "-DNO_WERROR WERROR="
    "DEBUG_FLAGS=-g"
    "-DWITHOUT_TESTS"
    "-DWITHOUT_MAN"
    "-DWITHOUT_MAIL"
    "-DWITHOUT_SENDMAIL"
    "-DWITHOUT_VT"
    "-DWITHOUT_DEBUG_FILES"
    "-DWITHOUT_BOOT"
    "-DWITH_AUTO_OBJ"
    "-DWITHOUT_GCC_BOOTSTRAP"
    "-DWITHOUT_CLANG_BOOTSTRAP"
    "-DWITHOUT_LLD_BOOTSTRAP"
    "-DWITHOUT_LIB32"
    "-DWITH_ELFTOOLCHAIN_BOOTSTRAP"
    "-DWITHOUT_TOOLCHAIN"
    "-DWITHOUT_BINUTILS_BOOTSTRAP"
    "-DWITHOUT_RESCUE"
    "-DWITHOUT_BLUETOOTH"
    "-DWITHOUT_SVNLITE"
    "-DWITHOUT_CDDL"
    "-DWITHOUT_PF"
    "-DWITHOUT_PROFILE"
    "-DWITHOUT_VI"
    "-DWITHOUT_SYSCONS"
    "-DWITHOUT_CTF"
    "MODULES_OVERRIDE="
  ];
}
