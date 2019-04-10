{ stdenv, callPackage, bash
, prefix ? "besspin" }:
{ baseName, longName, version, pkg }:

let
  tarFile = callPackage ./tar-file.nix {} baseName pkg;

in stdenv.mkDerivation rec {
  name = "${prefix}-unpack-${baseName}";
  buildInputs = [ bash pkg ];

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    substitute ${./unpack} "$out/bin/${name}" \
      --subst-var-by bash '${bash}' \
      --subst-var-by tarFile '${tarFile}' \
      --subst-var-by baseName '${baseName}' \
      --subst-var-by longName '${longName}' \
      --subst-var-by version '${version}'
    chmod +x "$out/bin/${name}"
  '';
}
