{ stdenv
, lib
, gfeSrc
, dtc
, riscv-openocd
, riscv-gcc
, riscv-gcc-linux
, processor-verilog
, processor-name
, gfe-target
}:

stdenv.mkDerivation rec {
  name = "${processor-name}-${gfe-target}-bitstream";

  src = gfeSrc.modules.".";

  # We can't run Vivado inside the Nix sandbox due to how the
  # licensing works
  __noChroot = true;

  buildInputs = [
    riscv-openocd
    riscv-gcc
    riscv-gcc-linux
    dtc
  ];

  proc = lib.concatStrings [processor-name "_" (lib.toLower gfe-target)];

  vivadoPath = "/opt/Xilinx/Vivado/2019.1";
  vivadoLicense = "/opt/Xilinx/Xilinx.lic";

  buildPhase = ''
    cat >init_submodules.sh <<EOF
    #!/usr/bin/env bash
    true
    EOF

    cat >tcl/proc_mapping.tcl <<EOF
    dict set proc_mapping ${proc} "${processor-verilog}/xilinx_ip"
    EOF

    export XILINXD_LICENSE_FILE=$vivadoLicense

    . $vivadoPath/settings64.sh

    ./setup_soc_project.sh $proc

    ./build.sh $proc
  '';

  installPhase = ''
    false
    mkdir -p $out/bitstreams
    cp bistreams/soc_${proc}.bit $out/bitstreams
  '';
}
