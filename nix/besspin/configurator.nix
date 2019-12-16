{ fetchGit2, srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = fetchGit2 {
    url = "git@gitlab-ext.galois.com:ssith/besspin-ui.git";
    rev = "2d1f623c793737b800b51e2492dc79accc2d0b97";
    ref = "master";
  };
}
