{ stdenv, lib }:
templatePath: args:

let
  argSubs = lib.concatMapStringsSep " "
    (k: "--subst-var-by '${k}' '${builtins.getAttr k args}'")
    (builtins.attrNames args);
  
in stdenv.mkDerivation rec {
  name = baseNameOf templatePath;
  buildInputs = builtins.attrValues args;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    substitute ${templatePath} "$out/bin/${name}" ${argSubs}
    chmod +x "$out/bin/${name}"
  '';
}
