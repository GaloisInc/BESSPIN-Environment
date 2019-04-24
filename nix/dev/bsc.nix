let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix { binaryLevel = 0; };

in mkShell {
  inputsFrom = with besspin; [ bscExport ];
}
