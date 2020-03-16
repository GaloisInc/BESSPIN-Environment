pkgs @ { stdenv
, bmake
, lib
, newScope
, fetchFromGitHub
, riscv-clang
, riscv-llvm
, riscv-lld
, clangStdenv
, which
, python3
, libarchive
, hostname
, zlib
, bash
, gfeSrc
, overrides ? (self: super: {})
}:


let
  bmakeFlagsMinimal = [
    "-DDB_FROM_SRC"
    "-DNO_ROOT"
    "-DBUILD_WITH_STRICT_TMPPATH"
    "TARGET=riscv"
    "TARGET_ARCH=riscv64"
    "-DNO_WERROR WERROR="
    "-DWITHOUT_TESTS"
    "-DWITHOUT_MAN"
    "-DWITHOUT_MAIL"
    "-DWITHOUT_VT"
    "-DWITHOUT_DEBUG_FILES"
    "-DWITHOUT_BOOT"
    "-DWITH_AUTO_OBJ"
    "-DWITHOUT_GCC_BOOTSTRAP"
    "-DWITHOUT_CLANG_BOOTSTRAP"
    "-DWITHOUT_LLD_BOOTSTRAP"
    "-DWITHOUT_LIB32"
    "-DWITH_ELFTOOLCHAIN_BOOTSTRAP"
    "-DWITHOUT_BINUTILS_BOOTSTRAP"
    "-DWITHOUT_RESCUE"
    "-DWITHOUT_BLUETOOTH"
    "-DWITHOUT_SVNLITE"
    "-DWITHOUT_CTF"
    "-DWITHOUT_CDDL"
    "-DWITHOUT_PF"
    "-DWITHOUT_PROFILE"
    "-DWITHOUT_VI"
    "-DWITHOUT_SYSCONS"
    "-DWITHOUT_DICT"
    "-DWITHOUT_EXAMPLES"
    "-DWITHOUT_HTML"
    "-DWITHOUT_FILE"
    "-DWITHOUT_MAKE"
    "-DWITHOUT_PORTSNAP"
    "-DWITHOUT_PKGBOOTSTRAP"
    "-DWITHOUT_OPENMP"
    "-DWITHOUT_SHAREDOCS"
    "-DWITHOUT_WIRELESS"
    "-DWITHOUT_KDUMP"
    "-DWITHOUT_AUDIT"
    "-DWITHOUT_TFTP"
    "-DWITHOUT_CXGBETOOL"
    "-DWITHOUT_LDNS"
    "-DWITHOUT_QUOTAS"
    "-DWITHOUT_TALK"
    "-DWITHOUT_USB"
    "-DWITHOUT_KERNEL_SYMBOLS"
    "-DWITHOUT_NLS"
    "-DWITHOUT_UTMPX"
    "-DWITHOUT_KERBEROS"
    "-DWITHOUT_LOCALES"
    "MODULES_OVERRIDE="
  ];

  version = "12.1";

  targets = self: rec {
    bmakeFlags = bmakeFlagsMinimal;
    inherit version;

    src = gfeSrc.modules."freebsd/cheribsd";

    callPackage = pkgs.newScope self;
    newScope = extra: pkgs.newScope (self // extra);
    mkFreebsdDerivation = callPackage ./freebsd.nix { inherit bmake; };

    freebsdWorld = callPackage ./freebsd-world.nix {
      inherit mkFreebsdDerivation;
    };
    freebsdImage = callPackage ./freebsd-rootfs-image.nix { };

    freebsdKernelQemu = callPackage ./freebsd-kernel.nix {
      inherit mkFreebsdDerivation;
      device = "QEMU";
    };
    freebsdKernelFpga = callPackage ./freebsd-kernel.nix {
      inherit mkFreebsdDerivation;
      device = "FPGA";
    };

    freebsdDebugKernelQemu = callPackage ./freebsd-kernel.nix {
      inherit mkFreebsdDerivation;
      device = "QEMU";
      noDebug = false;
    };
    freebsdDebugKernelFpga = callPackage ./freebsd-kernel.nix {
      inherit mkFreebsdDerivation;
      device = "FPGA";
      noDebug = false;
    };

    freebsdSysroot = callPackage ./sysroot.nix {};
  };
  in lib.fix' (lib.extends overrides targets)
