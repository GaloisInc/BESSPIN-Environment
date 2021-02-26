{ stdenv, gfeSrc, debianStage1Initramfs, debianRepoSnapshot, debianExtraPackages, useRsyslog ? true}:

# This package assembles the the virtual filesystem contents for running Debian
# stage1, which will be exposed via QEMU's `fat:$PATH` virtual FAT filesystem.
# See gfe/debian/stage1-init for info on what files it must contain.

stdenv.mkDerivation rec {
  name = "debian-stage1-virtual-disk";
  src = gfeSrc.modules.".";

  configurePhase = "";
  buildPhase = "";

  patches = if useRsyslog then [./exclude-docs.patch] else [ ./exclude-docs.patch ./no-rsyslog.patch ];

  dontFixup = true;

  installPhase = ''
    mkdir $out

    mkdir $out/scripts
    cp -r debian/{setup_chroot.sh,setup_scripts} $out/scripts/

    ln -s ${debianStage1Initramfs} $out/initramfs.cpio.gz

    ln -s ${debianRepoSnapshot} $out/debian-repo

    mkdir $out/pkgs
    ln -s ${debianExtraPackages.readline} $out/pkgs/libreadline.deb
    ln -s ${debianExtraPackages.gdb} $out/pkgs/gdb.deb
    ln -s ${debianExtraPackages.strace} $out/pkgs/strace.deb
  '';
}
