{ stdenv, callPackage }:

stdenv.mkDerivation rec {
  name = "featuresynth";
  src = callPackage ./arch-extract-src.nix {};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r featuresynth $out
  '';
}
