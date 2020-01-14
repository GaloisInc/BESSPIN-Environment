let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage;
  besspin = callPackage ../besspin-pkgs.nix {};

in mkShell {
  buildInputs = with pkgs; with besspin; [
    bscBinary
    bluespecP1Verilog
  ];
}
