{ stdenv, rvttSrc, go }:

stdenv.mkDerivation rec {
  name = "riscv-timing-tests";

  src = rvttSrc;

  buildInputs = [ go ];

  buildPhase = ''
    cd scripts
    go build driver.go
    go build latency-test.go
    cd ..
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp scripts/driver $out/bin/besspin-timing-test-driver
    cp scripts/latency-test $out/bin/besspin-timing-test-latency
    install -D -t $out/lib/ lib/libfesvr.so
  '';
}
