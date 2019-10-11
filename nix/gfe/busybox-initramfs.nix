{ stdenv, gfeSrc, riscvBusybox, genInitCpio }:

stdenv.mkDerivation rec {
  name = "busybox.cpio.gz";
  src = gfeSrc.modules.".";

  buildInputs = [ genInitCpio ];

  configurePhase = "";

  buildPhase = ''
    bootmem/build_busybox_initramfs.sh
  '';

  installPhase = ''
    cp bootmem/busybox-initramfs.cpio.gz $out
  '';

  BUSYBOX_PREFIX = riscvBusybox;
}
