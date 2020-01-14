{ mkRacketDerivation, fetchGit2 }:

mkRacketDerivation rec {
  pname = "bdd";
  version = "0.1";
  src = fetchGit2 {
    url = "git@gitlab-ext.galois.com:ssith/bdd-racket.git";
    rev = "13ae926cf3d1047cfcb62efaee120a904be72fb5";
  };

  racketDeps = [];

  patchPhase = ''
    rm example.rkt
  '';
}
