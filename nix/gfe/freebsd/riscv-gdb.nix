{ overrideCC, clangStdenv, riscv-clang
, riscv-llvm, riscv-lld, sysroot
, crossPrefix ? "riscv64-unknown-freebsd12.1" 
, fetchurl
, texinfo, bison, flex, python3, perl, gawk
, ncurses, readline, gmp, mpfr, expat, riscv-zlib
}:

let
  stdenvRiscv = overrideCC clangStdenv riscv-clang;
  ABIFlags = "-march=rv64imafdc -mabi=lp64d";
  ldSelect = "-fuse-ld=${riscv-lld}/bin/ld.lld";
  CFlags = "${ABIFlags} -Wno-error=sign-compare -mno-relax ${ldSelect}";
  CC="clang -target ${crossPrefix} --sysroot=${sysroot} ${CFlags}";
  LD="${CC} -L${crossPrefix}-ld";
  AR="${riscv-llvm}/bin/llvm-ar";
  RANLIB="${riscv-llvm}/bin/llvm-ranlib";

in stdenvRiscv.mkDerivation {
  pname = "${crossPrefix}-gdb";
  version = "8.3";

  src = fetchurl {
    url="https://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.gz";
    sha256="0a4arq0vaf9fhwxchv5p8ll8lfwbapw905zf33n0w3a4jb2nw9mj";
  };

  nativeBuildInputs = [riscv-llvm texinfo bison flex python3 perl gawk];
  buildInputs = [ ncurses readline gmp mpfr expat riscv-zlib ];

  configureFlags = [
      "--host=${crossPrefix}"
      "--with-sysroot=${sysroot}"
      "--disable-install-libbfd"
      "--disable-shared"
      "--enable-static"
      "--without-python"
      "--with-zlib=${riscv-zlib}"
    ];

  dontFixup = true;
  doCheck = false;

  inherit CC LD AR RANLIB;
}