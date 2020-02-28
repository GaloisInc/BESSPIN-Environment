# this library must match the libraries specified in nix/misc/debian-repo-files.json
# the version packages here can’t be any newer than in the Debian libraries

{ stdenv, fetchgit, overrideCC, riscv-gcc-linux }:
let

  stdenvRiscv = overrideCC stdenv riscv-gcc-linux;

in stdenvRiscv.mkDerivation {
  pname = "keyutils";
  version = "1.6";
  
  out = ["out"];
  
  src = fetchgit {
    url="git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git";
    rev="4723f0185d11b13df243ad3cd41fbddfed53b5b1";
    sha256="1xyzybbbrcjgnkhhb5ah4p9b15dhwny1rk9w6x211kb3w7bwki2l";
    fetchSubmodules= false;
  };

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    cp libkeyutils* $out/lib
    cp *.h $out/include
  '';

  CC="${riscv-gcc-linux}/bin/riscv64-unknown-linux-gnu-gcc -march=rv64imafdc -mabi=lp64d";
  AR="${riscv-gcc-linux}/bin/riscv64-unknown-linux-gnu-ar";
}
