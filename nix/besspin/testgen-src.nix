{}:

builtins.fetchGit {
  url = "git@gitlab-ext.galois.com:ssith/testgen.git";
  rev = "5c1668551fc47db28bebcbe32c80fd1560ec0c2d";
  ref = "nix-prep";
}
