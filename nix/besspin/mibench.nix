{ stdenv, lib, mibenchSrc
, riscv-gcc
, gfe-target ? "P1"
, skip-benches ? []
}:

let

  # List of supported benchmarks.  The others don't build.
  benches = [
    "adpcm_decode"
    "adpcm_encode"
    "aes"
    "basicmath"
    "blowfish"
    "crc"
    "dijkstra"
    "fft"
    "limits"
    "picojpeg"
    "randmath"
    "rc4"
    "rsa"
    "sha"
  ]
  # qsort fails to build (linker errors) on P2 with the new toolchain.
  # TODO: figure out why
  ++ lib.optional (gfe-target == "P1") "qsort";


  benchesStr = lib.concatStringsSep " "
    (builtins.filter (x: ! (builtins.elem x skip-benches)) benches);

  archFlags = if gfe-target == "P1" then "-march=rv32imac" else "";

in stdenv.mkDerivation rec {
  name = "mibench-${gfe-target}";
  src = mibenchSrc;

  buildPhase = ''
    for d in ${benchesStr}; do
      pushd "$d"
      make GFE_TARGET=${gfe-target} \
        CC="${riscv-gcc}/bin/${riscv-gcc.triple}-gcc ${archFlags}"\
        OBJDUMP=${riscv-gcc}/bin/${riscv-gcc.triple}-objdump \
        OBJCOPY=${riscv-gcc}/bin/${riscv-gcc.triple}-objcopy
      popd
    done
  '';

  installPhase = ''
    mkdir -p $out
    for d in ${benchesStr}; do
      cp "$d/main.elf" "$out/$d.bin"
    done
  '';

  buildInputs = [ riscv-gcc ];
}
