{ clangStdenv
, lib
, overrideCC
, riscv-clang
, riscv-llvm
, riscv-linker
, fetchFromGitHub
, crossPrefix ? "riscv64-unknown-linux-gnu"
, sysroot
, useLLD ? false
}:

let
  stdenvRiscv = overrideCC clangStdenv riscv-clang;

  ABIFlags = "-march=rv64imafdc -mabi=lp64d -fPIC";
  ldSelect = if useLLD then " -fuse-ld=lld" else " --gcc-toolchain=${riscv-linker}";
  CC="clang -target ${crossPrefix} ${ABIFlags} --sysroot=${sysroot} -Wall -lrt -fPIC -mno-relax ${ldSelect}";
  LD=CC;
  AR="llvm-ar";
  RANLIB="llvm-ranlib";

in stdenvRiscv.mkDerivation rec {
    pname = "${crossPrefix}-riscv-zlib";
    version = "1.2.11";

    src = fetchFromGitHub {
      owner = "madler";
      repo = "zlib";
      rev = "cacf7f1d4e3d44d871b605da3b647f07d718623f";
      sha256 = "037v8a9cxpd8mn40bjd9q6pxmhznyqpg7biagkrxmkmm91mgm5lg";
    };

    configurePhase = ''
      ./configure --prefix=$out --static
    '';

    buildInputs = [ riscv-llvm riscv-linker ];

    dontFixup = true;
    dontPatch = true;

    inherit CC LD AR RANLIB;
  }
