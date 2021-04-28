{ mkRacketDerivation, fetchGit2 }:

mkRacketDerivation rec {
  pname = "bdd";
  version = "0.1";
  src = fetchGit2 {
    url = "git@github.com:pcerman/bdd-racket.git";
    rev = "4edba235b632b4d9fdaf991c24168f1e76023b55";
  };

  racketDeps = [];

  # This patch is created from the 3 commits on the internal fork (https://gitlab-ext.galois.com/ssith/bdd-racket)
  patches = [ ./bdd-besspin.patch ];

}
