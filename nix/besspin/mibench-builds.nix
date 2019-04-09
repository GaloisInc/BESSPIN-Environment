{ stdenv, mibenchP1, mibenchP2 }:

stdenv.mkDerivation {
  name = "mibench-builds";
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/{p1,p2}
    cp ${mibenchP1}/*.bin $out/p1/
    cp ${mibenchP2}/*.bin $out/p2/
  '';
}
