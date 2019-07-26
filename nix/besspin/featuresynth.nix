{ stdenv, aeSrc }:

stdenv.mkDerivation rec {
  name = "featuresynth";
  src = aeSrc;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r featuresynth $out
  '';
}
