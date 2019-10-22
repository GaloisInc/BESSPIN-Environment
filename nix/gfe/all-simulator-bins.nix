{ stdenv, lib, callPackage
, besspinConfig }:

let
  defaultParts = {
    bluespec_p1 = callPackage ./simulator-bin.nix { proc="bluespec_p1"; };
    bluespec_p2 = callPackage ./simulator-bin.nix { proc="bluespec_p2"; };
    chisel_p1 = callPackage ./simulator-bin.nix { proc="chisel_p1"; };
    chisel_p2 = callPackage ./simulator-bin.nix { proc="chisel_p2"; };
    elf_to_hex = callPackage ./elftohex-bin.nix { };
  };

  defaultCpCommands = lib.concatMapStringsSep "\n"
    (name: "cp ${defaultParts."${name}"}/bin/gfe-simulator-${name} $out/bin/")
    (builtins.attrNames defaultParts);

  customBins = besspinConfig.customize.simulatorBins or null;
  customCpCommands = lib.concatMapStringsSep "\n"
    (name: "cp ${customBins."${name}"} $out/bin/gfe-simulator-${name}")
    (builtins.attrNames customBins);

  cpCommands = if customBins != null then customCpCommands else defaultCpCommands;

in stdenv.mkDerivation {
  name = "gfe-simulator-bins";

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    ${cpCommands}
  '';
}
