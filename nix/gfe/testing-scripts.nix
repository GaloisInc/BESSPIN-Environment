{ stdenv, gfeSrc }:

stdenv.mkDerivation rec {
  name = "gfe-program-fpga";
  src = gfeSrc;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir $out
    cp -r testing/scripts testing/targets $out
  '';
}
