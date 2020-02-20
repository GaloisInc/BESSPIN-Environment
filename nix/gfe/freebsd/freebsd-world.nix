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
    mkdir -p $out
    bmake -de DESTDIR=$out $bmakeFlags installworld
    bmake -de DESTDIR=$out $bmakeFlags distribution

    mkdir $source
    cp -R * $source

    TMPDIR=obj/$(realpath .)/riscv.riscv64/tmp
    mkdir -p $tools/bin
    cp $TMPDIR/usr/sbin/makefs $TMPDIR/usr/bin/mkimg $tools/bin
  '';
}
