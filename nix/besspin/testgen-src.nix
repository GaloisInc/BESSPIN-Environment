{}:

builtins.fetchGit {
  url = "git@gitlab-ext.galois.com:ssith/testgen.git";
  rev = "af43f045504a8d956c8182130a80695e2feabca7";
  ref = "nix-prep";
}
