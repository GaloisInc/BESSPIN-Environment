{ mkRacketDerivation, fetchGit2 }:

mkRacketDerivation rec {
  pname = "rfc6455";
  version = "20160918";
  src = fetchGit2 {
    url = "https://github.com/tonyg/racket-rfc6455.git";
    rev = "ba4fa215e3ec71741bd00bb9804c76fc2b3b9e2e";
  };
}
