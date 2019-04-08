{ binaryLevel ? 0 }:
let pkgs = import nix/pinned-pkgs.nix {};
in pkgs.callPackage nix/shell.nix { inherit binaryLevel; }
