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

let
  bmakeFlagsMinimal = [
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
  
  FreeBSDSrc = fetchFromGitHub {
    owner = "arichardson";
    repo = "freebsd";
    rev = "75dd3963e6b8eb7c9fca9e6fb55f51feb1bd17d5";
    sha256 = "1a509nyhwyw5wwpsjdpbrx2nyipxibfx28nb368nyqhdzq1xanwk";
  };
  
  freebsdTarget = {
      target ? "world",
      bmakeFlags ? bmakeFlagsMinimal,
      enableTools ? false,
      src ? FreeBSDSrc,
      version ? "12.1-patch"
  }: clangStdenv.mkDerivation rec {
    pname = "freebsd-${target}";

    inherit src version;

    buildInputs = [
      bmake
      libarchive
      which
      python3
      hostname
      zlib
    ];

    outputs = [ "out" ] ++ optional enableTools [ "tools" ];
    setOutputFlags = false;

    patches = [ ./freebsd-makefile.patch ];
    
    postPatch = ''
      mkdir locale
      sed -i "s@/usr/share/locale@$(realpath locale)@" Makefile.inc1
    '';

    buildPhase = ''
      unset STRIP
      mkdir obj
      bmake -de ${bmakeFlags}  \
        'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
        buildworld -j${NIX_BUILD_CORES}
    '';

    installPhase = ''
      mkdir -p $out/world
      bmake -de DESTDIR=$out/world ${bmakeFlags} install${target}
    '' + optionalString (target == "world") ''
      bmake -de DESTDIR=$out/world ${bmakeFlags} distribution
    '' + optionalString enableTools ''
      TMPDIR=obj/$(realpath .)/riscv.riscv64/tmp
      mkdir -p $tools/bin
      cp $TMPDIR/usr/sbin/makefs $TMPDIR/usr/bin/mkimg $tools/bin
    '';

    XCC = "${riscv-clang}/bin/clang";
    XCXX = "${riscv-clang}/bin/clang++";
    XCPP = "${riscv-clang}/bin/clang-cpp";
    XLD = "${riscv-lld}/bin/ld.lld";
    XOBJDUMP = "${riscv-llvm}/bin/llvm-objdump";
    XOBJCOPY = "${riscv-llvm}/bin/llvm-objcopy";
    XCFLAGS = "-fuse-ld=${riscv-lld}/bin/ld.lld -Qunused-arguments";
    MAKEOBJDIRPREFIX="$PWD/obj";
  };

in {
  world = freebsdTarget{
    target = "world";
    bmakeFlags = bmakeFlagsMinimal;
    enableTools = true;
  };
  kernel = freebsdTarget{
    target = "kernel";
    bmakeFlags = bmakeFlagsMinimal;
  };
}
