{ stdenv
, lib
, gfeSrc
, dtc
, hexdump
, python2
, riscv-openocd
, riscv-gcc
, riscv-gcc-linux
, processor-verilog
, processor-name
, gfe-target
, besspinConfig
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
    hexdump
    python2
  ];

  proc = lib.concatStrings [processor-name "_" (lib.toLower gfe-target)];
  proj = "soc_${proc}";

  XILINXD_LICENSE_FILE= besspinConfig.systemFiles.vivadoLicense;

  buildPhase = ''
    cat >init_submodules.sh <<EOF
    #!/usr/bin/env bash
    true
    EOF

    cat >tcl/proc_mapping.tcl <<EOF
    dict set proc_mapping ${proc} "${processor-verilog}/xilinx_ip"
    EOF

    # Vivado stalls forever if it doesn't have a home directory that
    # it can access
    mkdir vivado-home
    export HOME=$(pwd)/vivado-home

    . ${besspinConfig.systemFiles.vivadoPrefix}/settings64.sh

    ./setup_soc_project.sh $proc

    ./build.sh $proc
  '';

  installPhase = ''
    mkdir -p $out/bitstreams

    cp vivado/$proj/$proj.runs/impl_1/design_1.bit $out/bitstreams/$proj.bit
    cp vivado/$proj/$proj.runs/impl_1/design_1.ltx $out/bitstreams/$proj.ltx
  '';
}
