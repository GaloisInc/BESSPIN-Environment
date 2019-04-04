{ stdenv, verific, readline, zlib }:

stdenv.mkDerivation rec {
  name = "halcyon";

  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/halcyon.git";
    rev = "783f30d3eb4f700f14e3752c03b8bb0132e93f4c";
  };

  buildInputs = [ verific readline zlib ];

  buildPhase = ''
    make VERIFIC_ROOT=${verific}/verific/
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp halcyon $out/bin/besspin-halcyon
  '';
}
