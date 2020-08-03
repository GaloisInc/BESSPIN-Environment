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
, targetSsh ? null
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
    "-DWITHOUT_NLS"
    "-DWITHOUT_UTMPX"
    "-DWITHOUT_KERBEROS"
    "-DWITHOUT_LOCALES"
    "MODULES_OVERRIDE="
  ];

  version = "12.1";

  targets = self: rec {
    bmakeFlags = bmakeFlagsMinimal;
    inherit version targetSsh;

    src = gfeSrc.modules."freebsd/cheribsd";

    callPackage = pkgs.newScope self;
    newScope = extra: pkgs.newScope (self // extra);
    mkFreebsdDerivation = callPackage ./freebsd.nix { inherit bmake; };

    freebsdWorld = callPackage ./freebsd-world.nix {};
    freebsdImageQemu = callPackage ./freebsd-rootfs-image.nix { gfePlatform = "qemu"; };
    freebsdImageFpga = callPackage ./freebsd-rootfs-image.nix {
      gfePlatform = "fpga";
      defaultRootPassword = "ssithdefault";
    };

    freebsdKernelQemu = callPackage ./freebsd-kernel.nix {
      gfePlatform = "qemu";
      freebsdImage = freebsdImageQemu;
    };
    freebsdKernelFpga = callPackage ./freebsd-kernel.nix {
      gfePlatform = "fpga";
      freebsdImage = freebsdImageFpga;
    };

    freebsdDebugKernelQemu = callPackage ./freebsd-kernel.nix {
      gfePlatform = "qemu";
      noDebug = false;
      freebsdImage = freebsdImageQemu;
    };
    freebsdDebugKernelFpga = callPackage ./freebsd-kernel.nix {
      gfePlatform = "fpga";
      noDebug = false;
      freebsdImage = freebsdImageFpga;
    };

    freebsdImageConnectal = callPackage ./freebsd-rootfs-image.nix {
      gfePlatform = "connectal";
      defaultRootPassword = "ssithdefault";
      compressImage = true;
      imageSize = "2000m";
    };

    freebsdKernelConnectal = callPackage ./freebsd-kernel.nix {
      gfePlatform = "connectal";
    };

    freebsdSysroot = callPackage ./sysroot.nix {};
  };
  in lib.fix' (lib.extends overrides targets)
