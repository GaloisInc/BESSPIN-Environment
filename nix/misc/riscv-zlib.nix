{ stdenv
, overrideCC
, riscv-gcc
, fetchFromGitHub
, crossPrefix ? "riscv64-unknown-linux-gnu" 
}:

let
  stdenvRiscv = overrideCC stdenv riscv-gcc;

  ABIFlags = "-march=rv64imafdc -mabi=lp64d -fPIC";  
  CC="${crossPrefix}-gcc ${ABIFlags}";
  LD="${crossPrefix}-gcc ${ABIFlags}";
  AR="${crossPrefix}-ar";
  RANLIB="${crossPrefix}-ranlib";

in stdenvRiscv.mkDerivation rec {
    pname = "${crossPrefix}-riscv-zlib";
    version = "1.2.11";

    src = fetchFromGitHub {
      owner = "madler";
      repo = "zlib";
      rev = "cacf7f1d4e3d44d871b605da3b647f07d718623f";
      sha256 = "037v8a9cxpd8mn40bjd9q6pxmhznyqpg7biagkrxmkmm91mgm5lg";
    };
    
    inherit CC LD AR RANLIB;
  }
