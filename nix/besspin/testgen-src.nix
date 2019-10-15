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
    "." = fetchSsith "testgen" "cf44c67d71e49b1642dc1ca887df92fe261ddc5b" {};
    "poc-exploits" = fetchSsith "poc-exploits"
      "6a7a98cb0aa8fbcbc53084b656bfa8edb2718b96" { ref = "develop"; };
  };
}
