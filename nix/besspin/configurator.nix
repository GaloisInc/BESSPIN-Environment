{ srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/besspin-ui.git";
    rev = "dcf91bff01efedfecc7aa5f7c1b3879812921f0d";
  };
}
