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

  # Build a multi-output package. The package that builds the root
  # filesystem image needs the 'makefs', 'mkimg', and 'pwd_mkdb'
  # tools, which were built for the host platform during the FreeBSD
  # build. These go in the 'tools' output while the FreeBSD goes in
  # the 'out' output.
  outputs = ["out" "tools"];

  installPhase = ''
    mkdir -p $out
    bmake -de DESTDIR=$out $bmakeFlags installworld
    bmake -de DESTDIR=$out $bmakeFlags distribution

    TMPDIR=obj/$(realpath .)/riscv.riscv64/tmp
    mkdir -p $tools/bin
    cp $TMPDIR/usr/sbin/makefs $TMPDIR/usr/bin/mkimg $TMPDIR/usr/sbin/pwd_mkdb $tools/bin
  '';
}
