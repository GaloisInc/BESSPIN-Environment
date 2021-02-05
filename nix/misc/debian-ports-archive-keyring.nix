{ stdenv, fetchurl, dpkg }:

stdenv.mkDerivation rec {
  name = "debian-ports-archive-keyring-${version}";
  version = "2018.12.27";

  src = fetchurl {
    url = "https://snapshot.debian.org/archive/debian-ports/20181231T220243Z/pool/main/d/debian-ports-archive-keyring/debian-ports-archive-keyring_${version}_all.deb";
    sha256 = "15vspxdzd2b8r54gzyhhdd5hy1kj7902ww31w5cshpds3rbx0h3x";
  };

  buildInputs = [ dpkg ];

  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
        dpkg -x ${src} .
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r usr/share/keyrings $out/share/keyrings
  '';
}
