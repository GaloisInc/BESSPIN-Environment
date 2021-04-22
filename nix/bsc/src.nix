{ fetchGit2, assembleSubmodules }:

# Fetch BSC source.

let
  fetch' = name: rev: args: fetchGit2 ({
    name = "${name}-private";
    url = "git@github.com:GaloisInc/${name}.git";
    inherit rev;
  } // args);

  fetch = name: rev: fetch' name rev {};

in assembleSubmodules {
  name = "bsc-src-private";
  modules = {
    "." = fetch' "BESSPIN-BSC" "5a5759d1fafb19ae5555d2692b518e893a0733ba" {
      ref = "ast-export";
    };
  };
}
