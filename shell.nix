{ haveSrc ? false
}:
let pkgs = import nix/pinned-pkgs.nix {};
in pkgs.callPackage nix/shell.nix {
  inherit haveSrc;
}
