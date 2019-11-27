{ stdenv, alloy }:

let
  alloyJar = "${alloy}/share/alloy/alloy4.jar";

in stdenv.mkDerivation rec {
  name = "alloy-check";
  unpackPhase = ":";
  installPhase = ''
    mkdir $out
    cp ${alloyJar} $out/alloy4.2.jar
  '';
}
