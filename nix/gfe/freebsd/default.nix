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
, overrides ? (self: super: {})
}:


let
  freebsdSrc = fetchFromGitHub {
    owner = "arichardson";
    repo = "freebsd";
    rev = "75dd3963e6b8eb7c9fca9e6fb55f51feb1bd17d5";
    sha256 = "1a509nyhwyw5wwpsjdpbrx2nyipxibfx28nb368nyqhdzq1xanwk";
  };
  
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
    "-DWITHOUT_LOCALES"
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
    "-DWITHOUT_KERNEL_SYMBOLS"
    "-DWITHOUT_OPENSSH"
    "-DWITHOUT_KERBEROS"
    "MODULES_OVERRIDE="
  ];

  version = "12.1";
  
  targets = self: rec {
    bmakeFlags = bmakeFlagsMinimal;
    inherit version;

    src = freebsdSrc;

    callPackage = pkgs.newScope self;
    newScope = extra: pkgs.newScope (self // extra);
    mkFreebsdDerivation = callPackage ./freebsd.nix { inherit bmake; };
    
    freebsdWorld = callPackage ./freebsd-world.nix {inherit mkFreebsdDerivation;
      src = freebsdSrc;
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
  };
  in lib.fix' (lib.extends overrides targets)
