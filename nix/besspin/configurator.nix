{ fetchGit2, srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = fetchGit2 {
    url = "git@gitlab-ext.galois.com:ssith/besspin-ui.git";
    rev = "a7735f76b49de47b6fa63452e8affac950753155";
    ref = "master";
  };
}
