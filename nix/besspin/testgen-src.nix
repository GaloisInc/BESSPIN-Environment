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
    "." = fetchSsith "testgen" "71f015782ecfa94f3d4c3b640194479c0180321c" {};
    "poc-exploits" = fetchSsith "poc-exploits" "1699a59d859f14646bb37f9ad1e753deead1d81d" {};
  };
}
