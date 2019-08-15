{ stdenv, aeSrc }:

stdenv.mkDerivation rec {
  name = "rocket-chip-check-config";
  src = aeSrc;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r rocket-chip-check-config $out
  '';
}
