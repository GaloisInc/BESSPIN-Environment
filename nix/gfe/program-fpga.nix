{ stdenv, lib, gfeSrc, riscv-openocd
, besspinConfig
, bitstreams ? [] # Should be a list of bitstream packages. Ignored if
                  # besspinConfig.precompiledBitstreams not set to
                  # true
}:

let
  precompiled = besspinConfig.customize.bitstreams or "bitstreams";

  # Bitstreams are copied in order from this list of paths. If a
  # bitstream for the same type of processor is specified twice in the
  # list, the second one will override the first one. This means that
  # the packaged bitstreams override the precompiled ones. Since the
  # precompiled bitstreams are included in the list, there will always
  # be bitstreams for all of the processor types.
  bitstreamDirs = [precompiled] ++
                  (if !besspinConfig.precompiledBitstreams
                   then map (pkg: "${pkg}/bitstreams") bitstreams
                   else []);

in stdenv.mkDerivation rec {
  name = "gfe-program-fpga";
  src = gfeSrc;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/bitstreams

    cp program_fpga.sh setup_env.sh $out

    for d in ${lib.concatStringsSep " " bitstreamDirs}; do
      cp $d/* $out/bitstreams
    done

    mkdir $out/tcl
    cp tcl/prog_bit.tcl $out/tcl

    # Setup scripts expect to find openocd at a specific relative path
    mkdir -p $out/riscv-tools/bin
    ln -s ${riscv-openocd}/bin/openocd $out/riscv-tools/bin
  '';
}
