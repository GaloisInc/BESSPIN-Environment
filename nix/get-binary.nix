{ stdenv
, orig
}:

stdenv.mkDerivation rec {
  name = orig.name;
  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/tool-suite-binaries.git";
    rev = "7bc0e0ce9c5546aa9749c3f0c92b80d7a6e3e4ed";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r ${baseNameOf orig}/ $out/
  '';
}
