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
    "." = fetchSsith "testgen" "7a58ae226c2299810bf411d03e72fee885c5ef23" {};
    "poc-exploits" = fetchSsith "poc-exploits"
      "6a7a98cb0aa8fbcbc53084b656bfa8edb2718b96" { ref = "develop"; };
  };
}
