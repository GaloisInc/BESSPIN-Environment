{ clangStdenv
, riscv-clang
, riscv-llvm
, riscv-lld
, autoconf
, automake
, autoreconfHook
, overrideCC
, sysroot
, crossPrefix ? "riscv64-unknown-freebsd12.1" 
, fetchurl
}:

let
  stdenvRiscv = overrideCC clangStdenv riscv-clang;
  ABIFlags = "-march=rv64imafdc -mabi=lp64d -fPIC";  
  ldSelect = " -fuse-ld=${riscv-lld}/bin/ld.lld";
  CC="clang -target ${crossPrefix} ${ABIFlags} -mno-relax --sysroot=${sysroot} ${ldSelect}";
  LD=CC;
  AR="${riscv-llvm}/bin/llvm-ar";
  RANLIB="${riscv-llvm}/bin/llvm-ranlib";

in stdenvRiscv.mkDerivation {
  pname = "${crossPrefix}-gdb";
  version = "8.3";

  out = ["out"];

  src = fetchurl {
    url="https://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.gz";
    sha256="0a4arq0vaf9fhwxchv5p8ll8lfwbapw905zf33n0w3a4jb2nw9mj";
  };

  nativeBuildInputs = [autoconf automake autoreconfHook riscv-llvm];

  configureFlags = [
      "--host=${crossPrefix}"
      "--prefix=${placeholder "out"}"
      "--with-sysroot=${sysroot}"
    ];

  dontFixup = true;

  inherit CC LD AR RANLIB;
}