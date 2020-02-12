{ stdenv
, riscv-clang
, riscv-llvm
, riscv-lld
, fetchFromGitHub
, clangStdenv
, bmake
, which
, python3
, libarchive
, hostname
, zlib
, bash
}:

clangStdenv.mkDerivation {
  name = "freebsd";

  src = fetchFromGitHub {
    owner = "arichardson";
    repo = "freebsd";
    rev = "75dd3963e6b8eb7c9fca9e6fb55f51feb1bd17d5";
    sha256 = "1a509nyhwyw5wwpsjdpbrx2nyipxibfx28nb368nyqhdzq1xanwk";
  };

  buildInputs = [
    bmake
    libarchive
    which
    python3
    hostname
    zlib
  ];

  phases = [ "unpackPhase" "patchPhase" "buildPhase" "installPhase" ];

  XCC = "${riscv-clang}/bin/clang";
  XCXX = "${riscv-clang}/bin/clang++";
  XCPP = "${riscv-clang}/bin/clang-cpp";
  XLD = "${riscv-lld}/bin/ld.lld";
  XOBJDUMP = "${riscv-llvm}/bin/llvm-objdump";
  XOBJCOPY = "${riscv-llvm}/bin/llvm-objcopy";
  XCFLAGS = "-fuse-ld=${riscv-lld}/bin/ld.lld -Qunused-arguments";

  bmakeFlags = [
    "-DDB_FROM_SRC"
    "-DNO_ROOT"
    "-DBUILD_WITH_STRICT_TMPPATH"
    "TARGET=riscv"
    "TARGET_ARCH=riscv64"
    "-DNO_WERROR WERROR="
    "DEBUG_FLAGS=-g"
    "LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg"
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
    "WITHOUT_MODULES=malo"
  ];

  patchPhase = ''
    sed 's@/bin/bash@${bash}/bin/bash@' -i tools/build/Makefile
    sed 's./usr/bin/ar.ar.' -i tools/build/mk/Makefile.boot
    sed 's./usr/bin/nm.nm.' -i tools/build/mk/Makefile.boot
    sed 's./usr/bin/ranlib.ranlib.' -i tools/build/mk/Makefile.boot
    mkdir locale
    sed -i "s@/usr/share/locale@$(realpath locale)@" Makefile.inc1
    sed -i "s!^PATH=.*!PATH=\t$PATH!" Makefile
    sed 's./usr/bin/env.env.' -i Makefile
  '';

  buildPhase = ''
    unset STRIP
    mkdir obj
    export MAKEOBJDIRPREFIX=$PWD/obj
    bmake -de $bmakeFlags buildworld -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    mkdir -p $out/world
    bmake -de DESTDIR=$out/world $bmakeFlags installworld
    bmake -de DESTDIR=$out/world $bmakeFlags distribution
  '';
}
