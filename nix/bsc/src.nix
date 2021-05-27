{ fetchGit2, assembleSubmodules }:

# Fetch BSC source.

let
  fetch' = name: rev: args: fetchGit2 ({
    name = "${name}-private";
    url = "https://github.com/GaloisInc/${name}.git";
    inherit rev;
  } // args);

  fetch = name: rev: fetch' name rev {};

in assembleSubmodules {
  name = "bsc-src-private";
  modules = {
    "." = fetch' "BESSPIN-BSC" "9d2ddd747cf793b3ee275a141bb6c5e657d60ae2" {
      ref = "ast-export";
    };
  };
}
