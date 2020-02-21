{ stdenv, fetchgit, overrideCC, riscv-gcc-linux }:
let

  stdenvRiscv = overrideCC stdenv riscv-gcc-linux;

in stdenvRiscv.mkDerivation {
  name = "libkeyutils";
  
  out = ["out"];
  
  src = fetchgit {
    url="git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git";
    rev="704802463dd1fd74000132d4325300c718a4b474";
    sha256="076c73y0gl8mj09sdr0zbvr5b1hc1l87z9nszj4z5vrdq3bnrpsy";
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
