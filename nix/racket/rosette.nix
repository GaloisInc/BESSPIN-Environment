{ mkRacketDerivation, fetchGit2, rfc6455, z3 }:

mkRacketDerivation rec {
  pname = "rosette";
  version = "3.0";
  src = fetchGit2 {
    url = "https://github.com/emina/rosette.git";
    rev = "e4b56fae9492bf7287490d72772d97784154b565";
  };
  subdir = "rosette";

  racketDeps = [ rfc6455 ];
  buildInputs = [ z3 ];

  # Install z3 first, so the Rosette install script won't try to download its
  # own copy.  This doesn't really belong in `patchPhase`, but it's easier than
  # messing around with the `installPhase`.
  patchPhase = ''
    mkdir -p $out/bin
    ln -s ${z3}/bin/z3 $out/bin/z3
  '';
}
