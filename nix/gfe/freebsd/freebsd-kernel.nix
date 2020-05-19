{ freebsdWorld
, freebsdImage
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
    options     MD_ROOT
    options     P1003_1B_MQUEUE
    makeoptions MFS_IMAGE=${freebsdImage}
    options     ROOTDEVNAME=\"ufs:/dev/md0\"
  '' + lib.optionalString (device == "QEMU") ''
    options     HZ=100
  '' + ''
    EOF
    cat ${kernDir}/${kernConf} 
  '';

  installPhase = ''
    mkdir -p $out
    bmake -de DESTDIR=$out $bmakeFlags installkernel
  '';
}
