let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix { binaryLevel = 0; };

in mkShell {
  inputsFrom = with besspin; [
    aeDriver aeExportVerilog
    featuresynthWrapper   # for the racket dep
    verific
  ];
  buildInputs = with pkgs; with besspin; [
    python3
    racket

    graphviz alloy z3 jre
  ];
}
