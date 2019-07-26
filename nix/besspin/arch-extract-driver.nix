{ stdenv, aeSrc, haskellEnv }:

let
  ghc = haskellEnv.ghcWithPackages (ps: with ps; [
    clafer_0_5_0
    cborg
    graphviz
    syb
    union-find
    microlens-platform
    prettyprinter
    toml-parser
    simple-smt
    parsec
    attoparsec
    Glob
    temporary
    deepseq
  ]);

in stdenv.mkDerivation rec {
  name = "arch-extract-driver";

  src = aeSrc;

  buildInputs = [ ghc ];

  buildPhase = ''
    make driver
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp driver $out/bin/besspin-arch-extract-driver
  '';
}
