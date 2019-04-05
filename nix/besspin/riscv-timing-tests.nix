{ stdenv, callPackage, goPath, go }:

stdenv.mkDerivation rec {
  name = "riscv-timing-tests";

  src = callPackage ./riscv-timing-tests-src.nix {};

  buildInputs = [ goPath go ];

  buildPhase = ''
    export GOPATH=${goPath}
    cd scripts
    go build driver.go
    go build latency-test.go
    cd ..
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp scripts/driver $out/bin/besspin-timing-test-driver
    cp scripts/latency-test $out/bin/besspin-timing-test-latency
  '';
}
