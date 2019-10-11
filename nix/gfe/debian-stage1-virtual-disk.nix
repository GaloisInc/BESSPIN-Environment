{ stdenv, gfeSrc, debianStage1Initramfs, debianRepoSnapshot }:

# This package assembles the the virtual filesystem contents for running Debian
# stage1, which will be exposed via QEMU's `fat:$PATH` virtual FAT filesystem.
# See gfe/debian/stage1-init for info on what files it must contain.

stdenv.mkDerivation rec {
  name = "debian-stage1-virtual-disk";
  src = gfeSrc.modules.".";

  configurePhase = "";
  buildPhase = "";

  installPhase = ''
    mkdir $out

    mkdir $out/scripts
    ln -s ${gfeSrc.modules."."}/debian/{setup_chroot.sh,setup_scripts} $out/scripts/

    ln -s ${debianStage1Initramfs} $out/initramfs.cpio.gz

    ln -s ${debianRepoSnapshot} $out/debian-repo
  '';
}
