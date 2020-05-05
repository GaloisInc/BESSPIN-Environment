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
    touch bootmem/_rootfs/etc/my_test_file
    mkdir bootmem/_rootfs/my_test_folder
    bootmem/build_chainloader_initramfs.sh
  '';

  installPhase = ''
    cp bootmem/chainloader-initramfs.cpio.gz $out
  '';

  BUSYBOX_PREFIX = riscvBusybox;
}
