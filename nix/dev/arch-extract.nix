{}:

let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage lib;
  besspin = callPackage ../besspin-pkgs.nix {};

in mkShell {
  inputsFrom = with besspin;
    [
      aeDriver
      featuresynthWrapper   # for the racket dep
    ];
  buildInputs = with pkgs; with besspin; [
    python3
    racket

    aeExportVerilog
    aeExportBsv
    aeListBsvLibraries
    aeExportFirrtl
    rocketChipHelper
    #boomHelper
    nametag
    dtc   # used by boom build process
    rocketChipCheckConfigWrapper

    graphviz alloy z3 jre

    # Locale DB is required to use UTF-8 locales inside the nix-shell.  BSC
    # uses unicode characters in some generated names, and printing them fails
    # in the default locale.
    glibcLocales
  ];

  clafer = "${besspin.haskellEnv.clafer_0_5_besspin}/bin/clafer";

  LANG = "en_US.UTF-8";

  nixpkgs = pkgs.path;
}
