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
  
  installPhase = ''
    mkdir -p $out
    bmake -de DESTDIR=$out $bmakeFlags installkernel
  '';
}
