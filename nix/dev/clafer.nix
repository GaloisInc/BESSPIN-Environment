{}:

let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage lib;
  besspin = callPackage ../besspin-pkgs.nix {};

in mkShell {
  inputsFrom = with besspin; [
    haskellEnv.clafer_0_5_0.env
  ];
  buildInputs = with pkgs; with besspin; [
    alloy alloy-check

    # Locale DB is required to use UTF-8 locales inside the nix-shell.
    glibcLocales
  ];

  LANG = "en_US.UTF-8";

  nixpkgs = pkgs.path;
}
