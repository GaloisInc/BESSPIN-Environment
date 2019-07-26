{ stdenv, rvttSrc }:

stdenv.mkDerivation rec {
  name = "libfesvr";

  src = rvttSrc;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/lib
    cp lib/libfesvr.so $out/lib/
  '';
}
