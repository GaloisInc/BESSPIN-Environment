{ stdenv, gcc, rvttSrc, fesvr, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "riscv-timing-tests";

  phases = [ "unpackPhase" "installPhase" ];

  buildInputs = [ gcc.cc.lib fesvr autoPatchelfHook ];

  src = rvttSrc;

  installPhase = ''
    mkdir -p $out/results/{rocket,boom}/data
    cp -r bin src $out/
    autoPatchelfFile $out/bin/emulator-galois.system-P2Config
    autoPatchelfFile $out/bin/simulator-boom.system-BoomConfig
  '';
}
