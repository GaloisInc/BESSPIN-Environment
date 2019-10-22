{ stdenv, gfeSrc
, extraPatches ? [] }:

stdenv.mkDerivation rec {
  name = "linux-debian.config";
  src = gfeSrc.modules.".";

  buildInputs = [];
  patches = [ ./linux-config-debian-initramfs-source.patch ] ++ extraPatches;

  configurePhase = "";
  buildPhase = "";
  installPhase = ''
    cp bootmem/debian-linux.config $out
  '';
}
