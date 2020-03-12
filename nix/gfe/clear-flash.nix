{ stdenv, gfeSrc }:

stdenv.mkDerivation rec {
  name = "gfe-clear-flash";
  src = gfeSrc;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir $out
    cp tcl/program_flash bootmem/small.bin $out
  '';
}