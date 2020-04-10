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
    rev = "888649af7669af56120ee4eead6b03070c3bbef4";
    sha256 = "0qfrmp0bw6phijw2j0y5m6bnnflaigk6lhxx4yyanv22qc2rvzff";
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
