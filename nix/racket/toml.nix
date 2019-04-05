{ mkRacketDerivation, parsack }:

mkRacketDerivation rec {
  pname = "toml";
  version = "0.1";
  src = builtins.fetchGit {
    url = "https://github.com/greghendershott/toml.git";
    rev = "0321b8a99b950f2cddeae8227f79340c37df0533";
  };

  racketDeps = [parsack];

  patchPhase = ''
    rm toml-test.rkt
  '';
}
