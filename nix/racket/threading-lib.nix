{ mkRacketDerivation, fetchGit2 }:

mkRacketDerivation rec {
  pname = "threading-lib";
  version = "1.2";
  src = fetchGit2 {
    url = "https://github.com/lexi-lambda/threading";
    rev = "5490317b2ec03316cd87f84625bb8dde4c391a2a";
  };
  subdir = "threading-lib";

  racketDeps = [];
}
