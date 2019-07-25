{ stdenv, callPackage, verilator }:

stdenv.mkDerivation rec {
  name = "gfe-simulator-elftohex";
  src = callPackage ./gfe-src.nix {};

  buildInputs = [ verilator ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    make -C ./verilator_simulators/run/Tests/elf_to_hex 
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./verilator_simulators/run/Tests/elf_to_hex/elf_to_hex $out/bin/gfe-simulator-elf_to_hex
  '';

}
