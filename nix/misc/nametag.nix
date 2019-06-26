{ stdenv, callPackage }:

stdenv.mkDerivation rec {
  name = "nametag";

  src = callPackage ../besspin/arch-extract-src.nix {};

  buildPhase = ''
    gcc -O2 nametag.c -o nametag
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv nametag $out/bin
  '';
}
