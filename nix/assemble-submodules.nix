{ stdenv, lib }:
{ name ? "source", modules }:

stdenv.mkDerivation rec {
  inherit name;
  phases = [ "installPhase" ];
  installPhase = 
    lib.concatMapStrings (dest:
      let
        src = builtins.getAttr dest modules;
      in ''
        mkdir -p $out/${dest}
        cp -r ${src}/* $out/${dest}/
        chmod -R u+w $out/${dest}
      '') (builtins.attrNames modules);
  passthru = {
    inherit modules;
  };
}
