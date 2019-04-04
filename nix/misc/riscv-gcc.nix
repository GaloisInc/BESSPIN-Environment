{ stdenv, fetchFromGitHub
, curl, gawk, texinfo, bison, flex, gperf
, libmpc, mpfr, gmp, expat
# "RV32IMAC" is the standard form of Piccolo's "RV32ACIMU"
, riscv-arch ? "rv32imac"
}:

# --------------------------
# RISC-V GCC Toolchain Setup

let
  riscv-toolchain-ver = "7.2.0";
  arch = riscv-arch;

in stdenv.mkDerivation rec {
  name    = "riscv-${arch}-toolchain-${version}";
  version = "${riscv-toolchain-ver}-${builtins.substring 0 7 src.rev}";
  src     = fetchFromGitHub {
    owner  = "riscv";
    repo   = "riscv-gnu-toolchain";
    rev    = "64879b24e18572a3d67aa4268477946ddb248006";
    sha256 = "0pd94vz2ksbrl7v64h32y9n89x2b75da03kj1qcxl2z8wrfi107b";
    fetchSubmodules = true;
  };

  configureFlags   = [ "--with-arch=${arch}" ];
  installPhase     = ":"; # 'make' installs on its own
  hardeningDisable = [ "all" ];
  enableParallelBuilding = true;

  # Stripping/fixups break the resulting libgcc.a archives, somehow.
  # Maybe something in stdenv that does this...
  dontStrip = true;
  dontFixup = true;

  nativeBuildInputs = [ curl gawk texinfo bison flex gperf ];
  buildInputs = [ libmpc mpfr gmp expat ];
}