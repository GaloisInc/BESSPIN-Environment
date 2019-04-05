{ stdenv, lib }:
pkgs:

let
  copyCommands = lib.concatMapStringsSep "\n"
    (name:
      let
        src = builtins.getAttr name pkgs;
      in "mkdir -p $out/src/${name}; cp -r --no-target-directory ${src} $out/src/${name}")
    (builtins.attrNames pkgs);
in stdenv.mkDerivation rec {
  name = "gopath";
  phases = [ "installPhase" ];

  installPhase = ''
    ${copyCommands}
  '';
}
