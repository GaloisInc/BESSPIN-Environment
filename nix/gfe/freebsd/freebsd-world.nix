{
 lib
, mkFreebsdDerivation
, version
, src
, bmakeFlags
}:
  
mkFreebsdDerivation {
  inherit version src bmakeFlags;
  
  tname = "world";
  
  bmakeTargets = [ "buildworld" ];
  
  outputs = ["out" "source" "tools"];
  
  installPhase = ''
    mkdir -p $out/world
    bmake -de DESTDIR=$out/world $bmakeFlags installworld
    bmake -de DESTDIR=$out/world $bmakeFlags distribution
    
    mkdir $source
    cp -R * $source
    
    TMPDIR=obj/$(realpath .)/riscv.riscv64/tmp
    mkdir -p $tools/bin
    cp $TMPDIR/usr/sbin/makefs $TMPDIR/usr/bin/mkimg $tools/bin
  '';
}
