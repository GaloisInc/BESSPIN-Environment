{ stdenv
, riscv-clang
, riscv-llvm
, riscv-lld
, clangStdenv
, bmake
, which
, python3
, lib
, libarchive
, hostname
, zlib
, bash}:

a@{ tname
, version
, src
, bmakeFlags ? []
, bmakeTargets ? [ "buildworld" "buildkernel" ]
, ... }:
clangStdenv.mkDerivation ( rec {
  pname = "freebsd-${tname}";

  dontConfigure = true;
  dontFixup = true;

  buildInputs = [
    bmake
    libarchive
    which
    python3
    hostname
    zlib
  ];

  inherit src version bmakeTargets bmakeFlags;

  XCC = "${riscv-clang}/bin/clang";
  XCXX = "${riscv-clang}/bin/clang++";
  XCPP = "${riscv-clang}/bin/clang-cpp";
  XLD = "${riscv-lld}/bin/ld.lld";
  XOBJDUMP = "${riscv-llvm}/bin/llvm-objdump";
  XOBJCOPY = "${riscv-llvm}/bin/llvm-objcopy";
  XCFLAGS = "-fuse-ld=${riscv-lld}/bin/ld.lld -Qunused-arguments";

  patchPhase = ''
    runHook prePatch
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
    runHook postPatch
  '';

  setOutputFlags = false;

  buildPhase =
    let buildCommand = ''
      ${lib.concatMapStringsSep "\n" (tgt:
        ''
          bmake -de $bmakeFlags \
          'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg usr.sbin/pwd_mkdb' \
          ${tgt} -j$NIX_BUILD_CORES
        '') bmakeTargets}
    '';
    in ''
      runHook preBuild
      unset STRIP
      mkdir -p obj
      export MAKEOBJDIRPREFIX=$PWD/obj
      echo "Building targets: ${builtins.concatStringsSep " " bmakeTargets}"
      ${buildCommand}
      runHook postBuild
    '';
} // a)
