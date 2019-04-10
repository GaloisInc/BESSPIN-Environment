{ stdenv, callPackage }:

stdenv.mkDerivation rec {
  name = "gfe-program-fpga";
  src = callPackage ./gfe-src.nix {};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir $out
    cp -r testing/scripts testing/targets $out
  '';
}
