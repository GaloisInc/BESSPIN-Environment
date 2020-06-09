{ stdenv, riscv-llvm, riscv-clang, fetchFromGitHub, riscv64 ? true }:

let archFlags = if riscv64 then "-march=rv64imac -mabi=lp64" else "-march=rv32im -mabi=ilp32";
    target = if riscv64 then "riscv64-unknown-elf" else "riscv32-unknown-elf";
in stdenv.mkDerivation {
  name = "riscv-newlib";

  src = fetchFromGitHub {
    owner = "riscv";
    repo = "riscv-newlib";
    rev = "f289cef6be67da67b2d97a47d6576fa7e6b4c858";
    sha256 = "1szs8kgazp01l1llf1zigk1ismr8f9k39s9a9ks2s5dwa983pdi6";
  };

  configurePhase = ''
    mkdir build
    cd build
    ../configure \
        CC_FOR_TARGET=${riscv-clang}/bin/clang \
        CFLAGS_FOR_TARGET="-target ${target} ${archFlags} -mcmodel=medany -mno-relax -g -O2" \
        AR_FOR_TARGET=${riscv-llvm}/bin/llvm-ar \
        RANLIB_FOR_TARGET=${riscv-llvm}/bin/llvm-ranlib \
        --target=${target} \
        --with-newlib \
        --disable-libgloss \
        --prefix=$out
  '';

  dontFixup = true;
}
