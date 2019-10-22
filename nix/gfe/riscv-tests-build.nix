{ stdenv, gfeSrc }:

stdenv.mkDerivation {
  name = "gfe-riscv-tests-build";

  unpackPhase = ":";
  configulePhase = ":";
  buildPhase = ":";
  installPhase = ''
    mkdir $out $out/benchmarks
    cp -r ${gfeSrc.modules."riscv-tests/env"} $out/env
    cp -r ${gfeSrc.modules.riscv-tests}/benchmarks/common $out/benchmarks
    cp -r ${gfeSrc.modules.riscv-tests}/benchmarks/Makefile $out/benchmarks
  '';

}
