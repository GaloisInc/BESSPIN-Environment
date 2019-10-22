{ stdenv, gfeSrc, riscvBusybox, genInitCpio }:

stdenv.mkDerivation rec {
  name = "chainloader.cpio.gz";
  src = gfeSrc.modules.".";

  buildInputs = [ genInitCpio ];

  configurePhase = "";

  buildPhase = ''
    bootmem/build_chainloader_initramfs.sh
  '';

  installPhase = ''
    cp bootmem/chainloader-initramfs.cpio.gz $out
  '';

  BUSYBOX_PREFIX = riscvBusybox;
}
