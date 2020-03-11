{ stdenv, coremarkP1, coremarkP2, coremarkP3 }:

stdenv.mkDerivation {
  name = "coremark-builds";
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir $out
    cp ${coremarkP1}/coremark.bin $out/coremark-p1.bin
    cp ${coremarkP2}/coremark.bin $out/coremark-p2.bin
    cp ${coremarkP3}/coremark.bin $out/coremark-p3.bin
  '';
}
