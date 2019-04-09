{ stdenv, lib, callPackage
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
    "qsort"
    "randmath"
    "rc4"
    "rsa"
    "sha"
  ];

  benchesStr = lib.concatStringsSep " "
    (builtins.filter (x: ! (builtins.elem x skip-benches)) benches);

in stdenv.mkDerivation rec {
  name = "coremark-${gfe-target}-${riscv-gcc.arch}";
  src = callPackage ./mibench-src.nix {};

  buildPhase = ''
    for d in ${benchesStr}; do
      pushd "$d"
      make GFE_TARGET=${gfe-target} \
        CC=${riscv-gcc}/bin/${riscv-gcc.triple}-gcc \
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
