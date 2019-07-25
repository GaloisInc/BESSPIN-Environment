{ stdenv, callPackage, riscv-openocd }:

stdenv.mkDerivation rec {
  name = "gfe-program-fpga";
  src = callPackage ./gfe-src.nix {};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir $out

    cp program_fpga.sh setup_env.sh $out
    cp -r bitstreams $out

    mkdir $out/tcl
    cp tcl/prog_bit.tcl $out/tcl

    # Setup scripts expect to find openocd at a specific relative path
    mkdir -p $out/riscv-tools/bin
    ln -s ${riscv-openocd}/bin/openocd $out/riscv-tools/bin
  '';
}
