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
    "." = fetch' "BESSPIN-BSC" "823376c3704d08e00736bad36c7e1737ec2899dd" {
      ref = "ast-export";
    };
  };
}
