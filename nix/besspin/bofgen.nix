{ stdenv, callPackage, csmith-bof }:

stdenv.mkDerivation rec {
  name = "bofgen";
  src = callPackage ./testgen-src.nix {};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r bofgen $out
    substitute bofgen/config.py "$out/config.py" \
      --replace './csmith' '${csmith-bof}/bin/csmith'
  '';
}
