{ srcOnly }:

srcOnly {
  name = "besspin-configurator";

  src = builtins.fetchGit {
    url = "https://gitlab.com/ashay/bagpipe.git";
    rev = "2e0395e678df7d6acc78c59cf9e6369f399a49a9";
  };
}
