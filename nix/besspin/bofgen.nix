{ stdenv, csmith-bof }:

stdenv.mkDerivation rec {
  name = "bofgen";

  src = builtins.fetchGit {
    #url = "git@gitlab-ext.galois.com:ssith/testgen.git";
    url = "/home/stuart/work/testgen/.git";
    rev = "af43f045504a8d956c8182130a80695e2feabca7";
    ref = "nix-prep";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r bofgen $out
    substitute bofgen/config.py "$out/config.py" \
      --replace './csmith' '${csmith-bof}/bin/csmith'
  '';
}
