{ stdenv, gfeSrc, genInitCpio, fakeroot, cpio
, debootstrap, debianPortsArchiveKeyring, debianRepoSnapshot, dpkg }:

stdenv.mkDerivation rec {
  name = "debian-stage1.cpio.gz";
  src = gfeSrc.modules.".";

  buildInputs = [ genInitCpio fakeroot debootstrap dpkg cpio ];

  configurePhase = "";

  buildPhase = ''
    # Be very selective with patchShebangs - we don't want to inadvertently
    # patch the scripts that run inside the initramfs image.
    patchShebangs debian/create_chroot.sh
    debian/build_stage1_initramfs.sh
  '';

  installPhase = ''
    cp debian/stage1-initramfs.cpio.gz $out
  '';

  DEBIAN_PORTS_ARCHIVE_KEYRING =
    "${debianPortsArchiveKeyring}/share/keyrings/debian-ports-archive-keyring.gpg";
  GFE_DEBIAN_URL = "file://${debianRepoSnapshot}";
}
