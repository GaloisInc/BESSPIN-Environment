{ stdenv, callPackage } :

stdenv.mkDerivation rec {
  name = "libfesvr";

  src = callPackage ../besspin/riscv-timing-tests-src.nix {};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/lib
    cp lib/libfesvr.so $out/lib/
  '';
}
