{ srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/feature-model-configurator-ui.git";
    rev = "fbb361ba5ecf9cd1a3e0d2167f61071d6a205378";
  };
}
