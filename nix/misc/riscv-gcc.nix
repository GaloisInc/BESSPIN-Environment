# rv32-sail -- a RISC-V 32 emulator and software toolchain
#
# Copyright (c) 2017-2019 Austin Seipp
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
