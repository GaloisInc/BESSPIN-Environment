{ stdenv, flex, yacc, zlib
, version ? "2019-02"
, rev ? "0747952da1bda23408a738921be965917a13f3c6" }:

let
  platform = "linux";

in stdenv.mkDerivation rec {
  name = "verific-${version}";
  inherit version;

  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/verific.git";
    inherit rev;
  };

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
      cp $d/*.h $out/verific/$d/
      cp $d/$d-${platform}.a $out/verific/$d/

      for f in $d/*.h; do
        ln -s ../../verific/$f $out/include/verific/
      done
      ln -s ../verific/$d/$d-${platform}.a $out/lib/libverific_$d.a
    done
  '';
}
