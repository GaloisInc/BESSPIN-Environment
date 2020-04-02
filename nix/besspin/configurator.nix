{ fetchGit2, srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = fetchGit2 {
    url = "git@gitlab-ext.galois.com:ssith/besspin-ui.git";
    rev = "559985b1e1cec1915e1d8356dbb60dfb4d28f151";
    ref = "master";
  };
}
