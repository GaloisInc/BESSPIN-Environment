{ assembleSubmodules }:

let
  fetchSsith = name: rev: args: builtins.fetchGit ({
    name = "${name}-source";
    url = "git@gitlab-ext.galois.com:ssith/${name}.git";
    inherit rev;
  } // args);

in assembleSubmodules {
  name = "testgen-source";
  modules = {
    "." = fetchSsith "testgen" "083cd730099b84981f354a9db42362400b9edc8a" {};
    "poc-exploits" = fetchSsith "poc-exploits"
      "6a7a98cb0aa8fbcbc53084b656bfa8edb2718b96" { ref = "develop"; };
  };
}
