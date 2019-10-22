# gen_init_cpio + gen_initramfs_list.sh tools from the Linux kernel sources.
# These are used to build cpio-formatted initramfs images.
{ stdenv, gfeSrc }:

stdenv.mkDerivation rec {
  name = "gen-init-cpio";
  src = gfeSrc.modules.riscv-linux;

  buildInputs = [];

  configurePhase = "";

  buildPhase = ''
    gcc usr/gen_init_cpio.c -o usr/gen_init_cpio
    sed -e 's:usr/gen_init_cpio:gen_init_cpio:g' \
      <usr/gen_initramfs_list.sh >usr/gen_initramfs_list2.sh
    mv usr/gen_initramfs_list2.sh usr/gen_initramfs_list.sh
    chmod +x usr/gen_initramfs_list.sh
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp usr/gen_init_cpio $out/bin
    cp usr/gen_initramfs_list.sh $out/bin
  '';
}
