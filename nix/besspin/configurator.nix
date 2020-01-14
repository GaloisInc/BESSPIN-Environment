{ fetchGit2, srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = fetchGit2 {
    url = "git@gitlab-ext.galois.com:ssith/besspin-ui.git";
    rev = "d91072d52183367abcc279fcae49834f476e2be6";
    ref = "master";
  };
}
