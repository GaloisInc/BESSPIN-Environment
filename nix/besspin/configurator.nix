{ srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/feature-model-configurator-ui.git";
    rev = "b53f6875b0583f6d55e33ffedcecf373d196818d";
    ref = "nix-paths";
  };
}
