{ freebsdWorld
, freebsdImage
, mkFreebsdDerivation
, bmakeFlags
, lib
, version
, src
, device
}:
let
  kernDir = "./sys/riscv/conf";
  kernConf = "TSFREEBSD${device}";

in mkFreebsdDerivation {
  inherit src version;

  tname = "kernel-${device}";

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
    include     "GENERIC"
    options     TMPFS
    options     MD_ROOT
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
