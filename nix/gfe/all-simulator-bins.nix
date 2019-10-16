{ stdenv, lib, callPackage }:

let
  parts = {
    bluespec_p1 = callPackage ./simulator-bin.nix { proc="bluespec_p1"; };
    bluespec_p2 = callPackage ./simulator-bin.nix { proc="bluespec_p2"; };
    chisel_p1 = callPackage ./simulator-bin.nix { proc="chisel_p1"; };
    chisel_p2 = callPackage ./simulator-bin.nix { proc="chisel_p2"; };
    elf_to_hex = callPackage ./elftohex-bin.nix { };
  };

  cpCommands = lib.concatMapStringsSep "\n"
    (name: "cp ${parts."${name}"}/bin/gfe-simulator-${name} $out/bin/")
    (builtins.attrNames parts);

in stdenv.mkDerivation {
  name = "gfe-simulator-bins";

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    ${cpCommands}
  '';

  passthru = {
    inherit parts;
  };
}
