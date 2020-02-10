{ stdenv
, riscv-clang
, riscv-llvm
, riscv-lld
, fetchFromGitHub
, clangStdenv
, bmake
, libarchive
}:

clangStdenv.mkDerivation {
  name = "freebsd";

  src = fetchFromGitHub {
    owner = "arichardson";
    repo = "freebsd";
    rev = "75dd3963e6b8eb7c9fca9e6fb55f51feb1bd17d5";
    sha256 = "1a509nyhwyw5wwpsjdpbrx2nyipxibfx28nb368nyqhdzq1xanwk";
  };

  buildInputs = [ bmake libarchive ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  unpackPhase = ''
    unpackFile $src
    mkdir obj
  '';

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

  buildPhase = ''
    unset STRIP
    export MAKEOBJDIRPREFIX=$PWD/obj
    bmake -de -C source $bmakeFlags buildworld -j5
  '';

  installPhase = ''
    mkdir -p $out/world
    bmake -de -C source DESTDIR=$out/world $bmakeFlags installworld
    bmake -de -C source DESTDIR=$out/world $bmakeFlags distribution
  '';
}
