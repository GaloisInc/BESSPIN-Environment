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
    "." = fetchSsith "testgen" "756e3809758f4011569ef7ca0d9afb7be4966a2e" {};
    "poc-exploits" = fetchSsith "poc-exploits" "ab769c0823832a7466ea00be7ff92fed42895794" {};
    "FreeRTOS-mirror" = fetchGit2 {
      name = "FreeRTOS-mirror-source";
      url = "https://github.com/GaloisInc/FreeRTOS-mirror.git";
      rev = "df804fd916df6d5d66e864a56fc49f9dba994a65";
      ref = "develop";
    };
  };
}
