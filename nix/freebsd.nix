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

clangStdenv.mkDerivation rec {
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

  patchPhase = ''
    # Replace absolute paths in makefiles.
    sed 's@/bin/bash@${bash}/bin/bash@' -i tools/build/Makefile
    sed 's@/usr/bin/ar@ar@' -i tools/build/mk/Makefile.boot
    sed 's@/usr/bin/nm@nm@' -i tools/build/mk/Makefile.boot
    sed 's@/usr/bin/ranlib@ranlib@' -i tools/build/mk/Makefile.boot
    sed 's@/usr/bin/env@env@' -i Makefile
    mkdir locale
    sed -i "s@/usr/share/locale@$(realpath locale)@" Makefile.inc1

    # Change the default PATH defined in the main makefile. Trying to
    # do this by passing in a make flag breaks everything for some reason.
    sed -i "s!^PATH=.*!PATH=\t$PATH!" Makefile

    # GNU and BSD date have different options.
    sed -i 's/date -r $SOURCE_DATE_EPOCH/date -d @$SOURCE_DATE_EPOCH/' \
      sys/conf/newvers.sh
  '';

  outputs = [ "out" "tools" ];
  setOutputFlags = false;

  buildPhase = ''
    unset STRIP
    mkdir obj
    export MAKEOBJDIRPREFIX=$PWD/obj
    bmake -de $bmakeFlags  \
      'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
      buildworld -j$NIX_BUILD_CORES

    bmake -de $bmakeFlags buildkernel -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    mkdir -p $out/world
    bmake -de DESTDIR=$out/world $bmakeFlags installworld
    bmake -de DESTDIR=$out/world $bmakeFlags distribution
    bmake -de DESTDIR=$out/world $bmakeFlags installkernel

    TMPDIR=obj/$(realpath .)/riscv.riscv64/tmp
    mkdir -p $tools/bin
    cp $TMPDIR/usr/sbin/makefs $TMPDIR/usr/bin/mkimg $tools/bin
  '';
}
