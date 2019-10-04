{ stdenv, gfeSrc }:

stdenv.mkDerivation rec {
  name = "linux-busybox.config";
  src = gfeSrc.modules.".";

  buildInputs = [];
  patches = [ ./linux-config-busybox-initramfs-source.patch ];

  configurePhase = "";
  buildPhase = "";
  installPhase = ''
    cp bootmem/linux.config $out
  '';
}
