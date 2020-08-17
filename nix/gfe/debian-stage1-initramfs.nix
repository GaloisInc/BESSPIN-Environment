{ stdenv, gfeSrc, genInitCpio, fakeroot, cpio
, debootstrap, debianPortsArchiveKeyring, debianRepoSnapshot, dpkg }:

stdenv.mkDerivation rec {
  name = "debian-stage1.cpio.gz";
  src = gfeSrc.modules.".";

  buildInputs = [ genInitCpio fakeroot debootstrap dpkg cpio ];

  patches = [ ./debian-image.patch ];

  postPatch = ''
    # Be very selective with patchShebangs - we don't want to inadvertently
    # patch the scripts that run inside the initramfs image.
    for script in debian/*.sh; do
      patchShebangs "$script"
    done
  '';

  configurePhase = "";

  buildPhase = ''
    debian/build_stage1_initramfs.sh stage1
    debian/build_stage1_initramfs.sh
    '';

  installPhase = ''
    cp debian/stage1-initramfs.cpio.gz $out
  '';

  DEBIAN_PORTS_ARCHIVE_KEYRING =
    "${debianPortsArchiveKeyring}/share/keyrings/debian-ports-archive-keyring.gpg";
  GFE_DEBIAN_URL = "file://${debianRepoSnapshot}";
}
