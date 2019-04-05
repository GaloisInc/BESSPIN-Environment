{ stdenv, callPackage, zlib, verific, tinycbor }:

stdenv.mkDerivation rec {
  name = "arch-extract-export-verilog";

  src = callPackage ./arch-extract-src.nix {};

  buildInputs = [ zlib verific tinycbor ];

  buildPhase = ''
    make export-verilog
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp export-verilog $out/bin/besspin-arch-extract-export-verilog
  '';
}
