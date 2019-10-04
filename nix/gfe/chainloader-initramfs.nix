{ stdenv, gfeSrc, riscvBusybox, genInitCpio }:

stdenv.mkDerivation rec {
  name = "chainloader.cpio.gz";
  src = gfeSrc.modules.".";

  buildInputs = [ genInitCpio ];

  configurePhase = "";

  buildPhase = ''
    # Busybox components, all squashed to owner 0:0
    gen_initramfs_list.sh -u squash -g squash ${riscvBusybox} >bootmem/busybox.files

    gen_initramfs_list.sh -d >bootmem/default.files

    cat >bootmem/chainloader.files <<EOF
    file /init ${./chainloader-init} 0755 0 0
    EOF

    cat bootmem/busybox.files bootmem/default.files bootmem/chainloader.files | \
      gen_init_cpio -t $SOURCE_DATE_EPOCH - | \
      gzip --best >bootmem/chainloader.cpio.gz
  '';

  installPhase = ''
    cp bootmem/chainloader.cpio.gz $out
  '';
}
