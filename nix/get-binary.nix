{ stdenv
, orig
}:

stdenv.mkDerivation rec {
  name = orig.name;
  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/tool-suite-binaries.git";
    rev = "263249d6835d8c58a0d18f422d71318a5392ea58";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r ${orig.name}/ $out/
  '';
}
