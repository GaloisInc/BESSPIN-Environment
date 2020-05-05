{ stdenv, gfeSrc, riscvBusybox, genInitCpio }:

stdenv.mkDerivation rec {
  name = "chainloader.cpio.gz";
  src = gfeSrc.modules.".";

  buildInputs = [ genInitCpio ];

  patchPhase = ''
    for script in bootmem/*.sh; do
      patchShebangs "$script"
    done
  '';

  configurePhase = "";

  buildPhase = ''
    bootmem/build_chainloader_initramfs.sh
  '';

  installPhase = ''
    cp bootmem/chainloader-initramfs.cpio.gz $out
  '';

  BUSYBOX_PREFIX = riscvBusybox;
}
