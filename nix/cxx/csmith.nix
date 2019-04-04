# Copyright (c) 2003-2019 Eelco Dolstra and the Nixpkgs/NixOS contributors
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

{ stdenv, fetchurl, cmake, m4, makeWrapper, libbsd, perlPackages }:

let
  perl = perlPackages.perl;
  SysCPU = perlPackages.SysCPU;
in stdenv.mkDerivation rec {
  name = "csmith-${version}";
  version = "2.4.0";

  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/csmith.git";
    rev = "7e5d69bdd7a4002b832533b52db8813ca5f29af1";
    ref = "bof";
  };

  nativeBuildInputs = [ cmake m4 makeWrapper ];
  buildInputs = [ perl SysCPU libbsd ];

  postInstall = ''
    substituteInPlace $out/bin/compiler_test.pl \
      --replace '$CSMITH_HOME/runtime' $out/include/${name} \
      --replace ' ''${CSMITH_HOME}/runtime' " $out/include/${name}" \
      --replace '$CSMITH_HOME/src/csmith' $out/bin/csmith

    substituteInPlace $out/bin/launchn.pl \
      --replace '../compiler_test.pl' $out/bin/compiler_test.pl \
      --replace '../$CONFIG_FILE' '$CONFIG_FILE'

    wrapProgram $out/bin/launchn.pl \
      --prefix PERL5LIB : "$PERL5LIB"

    mkdir -p $out/share/csmith
    mv $out/bin/compiler_test.in $out/share/csmith/
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A random generator of C programs";
    homepage = https://embed.cs.utah.edu/csmith;
    # Officially, the license is this: https://github.com/csmith-project/csmith/blob/master/COPYING
    license = licenses.bsd2;
    longDescription = ''
      Csmith is a tool that can generate random C programs that statically and
      dynamically conform to the C99 standard. It is useful for stress-testing
      compilers, static analyzers, and other tools that process C code.
      Csmith has found bugs in every tool that it has tested, and has been used
      to find and report more than 400 previously unknown compiler bugs.
    '';
    maintainers = [ maintainers.dtzWill ];
    platforms = platforms.all;
  };
}
