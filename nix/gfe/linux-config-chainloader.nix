{ stdenv, gfeSrc }:

stdenv.mkDerivation rec {
  name = "linux-chainloader.config";
  src = gfeSrc.modules.".";

  buildInputs = [];
  patches = [];

  configurePhase = "";
  buildPhase = "";
  installPhase = ''
    cp bootmem/chainloader-linux.config $out
  '';
}
