{ stdenv, gfeSrc }:

stdenv.mkDerivation rec {
  name = "linux-chainloader.config";
  src = gfeSrc.modules.".";

  buildInputs = [];
  patches = [ ./linux-config-chainloader-initramfs-source.patch ];

  configurePhase = "";
  buildPhase = "";
  installPhase = ''
    cp bootmem/chainloader-linux.config $out
  '';
}
