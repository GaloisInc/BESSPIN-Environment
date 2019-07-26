{ stdenv, halcyonSrc, verific, readline, zlib }:

stdenv.mkDerivation rec {
  name = "halcyon";

  src = halcyonSrc;

  buildInputs = [ verific readline zlib ];

  buildPhase = ''
    make VERIFIC_ROOT=${verific}/verific/
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp halcyon $out/bin/besspin-halcyon
  '';
}
