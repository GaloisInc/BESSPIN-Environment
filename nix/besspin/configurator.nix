{ srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/feature-model-configurator-ui.git";
    rev = "e31fb6060d323f1dae5a3813688e20b478ab17aa";
    ref = "fix-multi-top-level-features";
  };
}
