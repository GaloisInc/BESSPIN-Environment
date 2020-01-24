{ stdenv, lib, gfeSrc, riscv-openocd
, besspinConfig
, bitstreams ? [] # Should be a list of bitstream packages. Ignored if
                  # besspinConfig.precompiledBitstreams not set to
                  # true
}:

let
  bitstreamDirs = if besspinConfig.precompiledBitstreams
                  then [besspinConfig.customize.bitstreams or "bitstreams"]
                  else map (pkg: "${pkg}/bitstreams") bitstreams;

in stdenv.mkDerivation rec {
  name = "gfe-program-fpga";
  src = gfeSrc;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/bitstreams

    cp program_fpga.sh setup_env.sh $out
    cp -r ${lib.concatStringsSep " " (map (dir: dir + "/*") bitstreamDirs)} $out/bitstreams

    mkdir $out/tcl
    cp tcl/prog_bit.tcl $out/tcl

    # Setup scripts expect to find openocd at a specific relative path
    mkdir -p $out/riscv-tools/bin
    ln -s ${riscv-openocd}/bin/openocd $out/riscv-tools/bin
  '';
}
