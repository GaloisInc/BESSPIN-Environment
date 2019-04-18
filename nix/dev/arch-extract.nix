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

    # Locale DB is required to use UTF-8 locales inside the nix-shell.  BSC
    # uses unicode characters in some generated names, and printing them fails
    # in the default locale.
    glibcLocales
  ];

  LANG = "en_US.UTF-8";
}
