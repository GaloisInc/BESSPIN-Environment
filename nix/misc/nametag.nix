{ stdenv, aeSrc }:

stdenv.mkDerivation rec {
  name = "nametag";

  src = aeSrc;

  buildPhase = ''
    gcc -O2 nametag.c -o nametag
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv nametag $out/bin
  '';
}
