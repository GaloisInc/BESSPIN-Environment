{ stdenv
, orig
}:

stdenv.mkDerivation rec {
  name = orig.name;
  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/tool-suite-binaries.git";
    rev = "de2e533e967e76a9417c891a4300876dac360ba3";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r ${baseNameOf orig}/ $out/
  '';
}
