{ fetchGit2, srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = fetchGit2 {
    url = "git@gitlab-ext.galois.com:ssith/besspin-ui.git";
    rev = "f7a0f3e4cbee5802a7399b9be46f75c5b01ce3c8";
    ref = "master";
  };
}
