{ stdenv
, bscBinary
, gfeSrc
}:

stdenv.mkDerivation rec {
  name = "besspin-p1-verilog";

  # We can't use sandboxing since bsc needs access to the eth0 network
  # interface in order to check the license.
  __noChroot = true;

  src = gfeSrc.modules."bluespec-processors/P1/Piccolo";

  buildInputs = [ bscBinary ];

  # The makefiles for the bluespec processors pass the
  # -no-show-timestamps flag to the compiler. This isn't supported by
  # any publicly available version of bsc, but everything compiles
  # just fine if we remove it.
  buildPhase = ''
    cd src_SSITH_P1
    sed s/-no-show-timestamps// Makefile >Makefile_new
    export BLUESPEC_LICENSE_FILE=/opt/Bluespec-2017.07.A/bluespec.lic
    make -f Makefile_new compile
  '';

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";

  installPhase = ''
    mkdir -p $out
    cp -r xilinx_ip $out
  '';
}
