{ stdenv, lib }:
name: templatePath: args:

let
  argSubs = lib.concatMapStringsSep " "
    (k: "--subst-var-by '${k}' '${builtins.getAttr k args}'")
    (builtins.attrNames args);
  
in stdenv.mkDerivation rec {
  inherit name;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    substitute ${templatePath} "$out/bin/${name}" ${argSubs}
    chmod +x "$out/bin/${name}"
  '';
}
