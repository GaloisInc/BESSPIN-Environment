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
  enableSource = false;
}).overrideAttrs (old: rec {
  
  pname = old.pname + "-kernel" + "-${device}";

  # speed up build time
  src = freebsdWorld.source;
  buildInputs = old.buildInputs ++ [ freebsdWorld.tools ];

  patchPhase = ''
    echo 'include     "GENERIC"'                    > ${kernDir}/${kernConf}
    echo 'options     TMPFS'                        >> ${kernDir}/${kernConf}
    echo 'options     MD_ROOT'                      >> ${kernDir}/${kernConf}
    echo 'makeoptions   MFS_IMAGE=${freebsdImage}'  >> ${kernDir}/${kernConf}
    echo 'options ROOTDEVNAME=\"ufs:/dev/md0\"'             >> ${kernDir}/${kernConf}
  '' + lib.optionalString (device == "QEMU") ''
    echo 'options     HZ=100'                       >> ${kernDir}/${kernConf}
  '' + ''
    cat ${kernDir}/${kernConf} 
  '';

  bmakeFlags = old.bmakeFlags ++ [ 
    "-DNO_CLEAN"
    "-DI_REALLY_MEAN_NO_CLEAN"
    "KERNCONF=${kernConf}" ];

  bmakeTargets = [
    "_worldtmp"
    "_legacy"
    "_bootstrap-tools"
    "_cross-tools"
    "buildkernel"
  ];

  buildPhase = ''
    unset STRIP
    mkdir -p obj
    export MAKEOBJDIRPREFIX=$PWD/obj
      ${lib.concatMapStringsSep "\n" (tgt: ''bmake -de $bmakeFlags \
      'LOCAL_XTOOL_DIRS=lib/libnetbsd usr.sbin/makefs usr.bin/mkimg' \
      ${tgt} -j$NIX_BUILD_CORES 
    '') bmakeTargets}
  '';

  installPhase = ''
    TMPDIR=obj/$(realpath .)/riscv.riscv64/sys/${kernConf}
    echo tmpcreate
    cp $TMPDIR/kernel $out
    echo cpexec
  '';

}) 
