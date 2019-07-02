{ stdenv, fetchurl, gnupg }:

stdenv.mkDerivation rec {
  name = "debian-ports-archive-keyring-${version}";
  version = "2018.12.27";

  src = fetchurl {
    url = "mirror://debian/pool/main/d/debian-ports-archive-keyring/debian-ports-archive-keyring_${version}.tar.xz";
    sha256 = "10sjghh2yj789mg8fypiihhjvsbyylrbnbpirznm3zcqy0k514xg";
  };

  buildInputs = [ gnupg ];

  # Taken from debian/rules
  buildPhase = ''
    GPG_OPTIONS="--no-options --no-default-keyring --no-auto-check-trustdb"

    # Build keyrings
    mkdir -p build/keyrings
    gpg $GPG_OPTIONS --no-keyring --import-options import-export --import active-keys/* > build/keyrings/debian-ports-archive-keyring.gpg
    gpg $GPG_OPTIONS --no-keyring --import-options import-export --import removed-keys/* > build/keyrings/debian-ports-archive-keyring-removed.gpg
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r build/keyrings $out/share/keyrings
  '';
}
