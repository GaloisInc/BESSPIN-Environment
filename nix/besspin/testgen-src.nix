{ fetchGit2, assembleSubmodules }:

let
  fetchSsith = name: rev: args: fetchGit2 ({
    name = "${name}-source";
    url = "git@gitlab-ext.galois.com:ssith/${name}.git";
    inherit rev;
  } // args);

in assembleSubmodules {
  name = "testgen-source";
  modules = {
    "." = fetchSsith "testgen" "8e36fad2d003443f8181899f9b8017856c11af1d" {};
    "poc-exploits" = fetchSsith "poc-exploits"
      "231af46abfd52240aa800690b767cf556cc9070d" { ref = "develop"; };
  };
}
