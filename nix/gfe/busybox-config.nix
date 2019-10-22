{ stdenv, gfeSrc }:

stdenv.mkDerivation rec {
  name = "busybox.config";
  src = gfeSrc.modules.".";

  buildInputs = [];

  configurePhase = "";
  buildPhase = "";
  installPhase = ''
    cp bootmem/busybox.config $out
  '';
}
