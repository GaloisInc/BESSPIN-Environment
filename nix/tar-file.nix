{ stdenv }:
baseName: pkg:

stdenv.mkDerivation rec {
  name = "${baseName}.tar";
  buildInputs = [ ];

  phases = [ "installPhase" ];

  installPhase = ''
    tar -C "${pkg}" --mode=u+w -cf $out .
  '';
}
