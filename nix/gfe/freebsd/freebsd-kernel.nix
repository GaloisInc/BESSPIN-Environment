{ freebsdWorld
, freebsdImage ? null
, mkFreebsdDerivation
, bmakeFlags
, lib
, version
, src
, device
, noDebug ? true
}:
let
  kernDir = "./sys/riscv/conf";
  kernConf = "BESSPIN-${device}" + lib.optionalString noDebug "-NODEBUG";

in mkFreebsdDerivation {
  inherit src version;

  tname = "kernel-${device}" + lib.optionalString (!noDebug) "-DEBUG";

  bmakeFlags = bmakeFlags ++ [
    "-DNO_CLEAN"
    "-DI_REALLY_MEAN_NO_CLEAN"
    "KERNCONF=${kernConf}"
  ];

  bmakeTargets = [
    "_worldtmp"
    "_legacy"
    "_bootstrap-tools"
    "_cross-tools"
    "buildkernel"
  ];

  postPatch = ''
    cat <<EOF > ${kernDir}/${kernConf}
    include     "GENERIC${lib.optionalString noDebug "-NODEBUG"}"
    options     TMPFS
    options     P1003_1B_MQUEUE
    device		virtio_random
  '' + lib.optionalString (device == "QEMU" || device == "connectal") ''
    options     HZ=100
  '' + lib.optionalString (device != "connectal") ''
    options     MD_ROOT
    makeoptions MFS_IMAGE=${freebsdImage}
    options     ROOTDEVNAME=\"ufs:/dev/md0\"
  '' + lib.optionalString (device == "connectal") ''
    options 	ROOTDEVNAME=\"ufs:/dev/vtbd0\"
    makeoptions 	KERNEL_LMA=0xc0200000
    options 	BREAK_TO_DEBUGGER
    options 	ALT_BREAK_TO_DEBUGGER
  '' + ''
    EOF
    cat ${kernDir}/${kernConf} 
  '';

  installPhase = ''
    mkdir -p $out
    bmake -de DESTDIR=$out $bmakeFlags installkernel
  '';
}
