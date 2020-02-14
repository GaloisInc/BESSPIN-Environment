{ freebsdWorld
, freebsdImage
, lib
, device ? "QEMU" }:
let
  kernDir = "./sys/riscv/conf";
  kernConf = "TSFREEBSD${device}";
in
(freebsdWorld.override {
  enableTools = false;
}).overrideAttrs (old: {
  pname = old.pname + "-kernel";

  patchPhase = old.patchPhase + ''
    echo 'include     "GENERIC"'                    > ${kernDir}/${kernConf}
    echo 'options     TMPFS'                        >> ${kernDir}/${kernConf}
    echo 'options     MD_ROOT'                      >> ${kernDir}/${kernConf}
    echo 'makeoptions   MFS_IMAGE=${freebsdImage}'  >> ${kernDir}/${kernConf}
    echo 'ROOTDEVNAME=\"ufs:/dev/md0\"'             >> ${kernDir}/${kernConf}
  '' + lib.optionalString (device == "QEMU") ''
    echo 'options     HZ=100'                       > ${kernDir}/${kernConf}
  '' + ''
    cat ${kernDir}/${kernConf} 
  '';

  bmakeFlags = old.bmakeFlags ++ [ "KERNCONF=${kernConf}" ];

  buildPhase = ''
    unset STRIP
    mkdir obj
    export MAKEOBJDIRPREFIX=$PWD/obj
    bmake -de $bmakeFlags \
      'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
      _worldtmp -j$NIX_BUILD_CORES
    bmake -de $bmakeFlags \
      'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
      _legacy -j$NIX_BUILD_CORES
    bmake -de $bmakeFlags \
      'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
      _bootstrap-tools -j$NIX_BUILD_CORES
    bmake -de $bmakeFlags \
      'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
      _cross-tools -j$NIX_BUILD_CORES
    bmake -de $bmakeFlags \
      'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
      buildKernel -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    mkdir -p $out/kernel
    bmake -de DESDIR=$out/world $bmakeFlags installKernel 
  '';

}) 
