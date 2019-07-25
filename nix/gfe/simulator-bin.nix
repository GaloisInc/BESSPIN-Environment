{ stdenv, callPackage, verilator, glibc
, proc }:

stdenv.mkDerivation rec {
  name = "gfe-simulator-bin";
  src = callPackage ./gfe-src.nix {};

  buildInputs = [ verilator ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    make -C ./verilator_simulators PROC=${proc} 
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./verilator_simulators/run/exe_HW_${proc}_sim $out/bin/gfe-simulator-${proc}
  '';

  GLIBC_STATIC = glibc.static;
}
