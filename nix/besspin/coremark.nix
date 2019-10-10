{ stdenv, coremarkSrc
, riscv-gcc
, gfe-target ? "P1"
, iterations ? "2000"
}:

stdenv.mkDerivation rec {
  name = "coremark-${gfe-target}";
  src = coremarkSrc;

  buildPhase = ''
    make \
      PORT_DIR=riscv-bare-metal \
      GFE_TARGET=${gfe-target} \
      ITERATIONS=${iterations} \
      CC=${riscv-gcc}/bin/${riscv-gcc.triple}-gcc \
      coremark.bin
  '';

  installPhase = ''
    mkdir -p $out
    cp coremark.bin $out/coremark.bin
  '';

  buildInputs = [ riscv-gcc ];
}
