{ stdenv, gfeSrc, riscvBusybox, genInitCpio }:

stdenv.mkDerivation rec {
  name = "busybox.cpio.gz";
  src = gfeSrc.modules.".";

  buildInputs = [ genInitCpio ];

  configurePhase = "";

  buildPhase = ''
    # Busybox components, all squashed to owner 0:0
    gen_initramfs_list.sh -u squash -g squash ${riscvBusybox} >bootmem/busybox.files

    gen_initramfs_list.sh -u squash -g squash bootmem/_rootfs >bootmem/rootfs.files

    cat bootmem/busybox.files bootmem/rootfs.files bootmem/initramfs.files | \
      gen_init_cpio -t $SOURCE_DATE_EPOCH - | \
      gzip --best >bootmem/busybox.cpio.gz
  '';

  installPhase = ''
    cp bootmem/busybox.cpio.gz $out
  '';
}
