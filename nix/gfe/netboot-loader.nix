{ stdenv
, fetchFromGitHub
, riscv-gcc
}:

stdenv.mkDerivation rec {
  name = "freertos-netboot";

  # Point this to GFE when it updates
  src = fetchFromGitHub {
    owner = "GaloisInc";
    repo = "FreeRTOS-mirror";
    rev = "21c509c27db35febdec0ac5e82ac5c007aadeea2";
    sha256 = "1cygg80k81ar17yrdcdw286yk5srm4acd3zhbimrd04v8bf6sff1";
  };

  buildInputs = [ riscv-gcc ];

  dontConfigure = true;
  dontFixup = true;

  preBuild = ''
    cd FreeRTOS/Demo/RISC-V_Galois_P1
  '';

  makeFlags = [ "PROG=main_netboot" "XLEN=64" "configCPU_CLOCK_HZ=100000000" ];

  installPhase = ''
    cp main_netboot.elf $out
  '';
}
