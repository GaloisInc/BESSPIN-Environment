{ stdenv, flex, yacc, zlib
, togglePackagePrivate
, version ? "2019-02"
, rev ? "0747952da1bda23408a738921be965917a13f3c6"
, sha256 ? "17h5b7ln1njrx64kl57fkda1v4cqjbmyl6052x68mmqgqd93lnv4"
}:

let
  platform = "linux";

  realSrc = builtins.fetchGit {
    name = "verific-source-private";
    url = "git@gitlab-ext.galois.com:ssith/verific.git";
    inherit rev;
  };

in stdenv.mkDerivation rec {
  name = "verific-private-${version}";
  inherit version;

  src = togglePackagePrivate "verific" sha256 realSrc;

  buildInputs = [ flex yacc zlib ];

  buildPhase = ''
    make -C util
    make -C containers
    make -C database
    make -C verilog
  '';

  installPhase = ''
    # `$out/include` and `$out/lib` contain the headers and libraries using the
    # standard naming and layout.  `$out/verific` contains the same files, but
    # mimics the layout of the Verific source tree.

    mkdir -p $out $out/include/verific $out/lib $out/verific
    for d in util containers database verilog; do
      mkdir $out/verific/$d
      cp $d/*.h $out/include/verific/
      cp $d/*.h $out/verific/$d/
      cp $d/$d-${platform}.a $out/verific/$d/
      cp $d/$d-${platform}.a $out/lib/libverific_$d.a
    done
  '';
}
