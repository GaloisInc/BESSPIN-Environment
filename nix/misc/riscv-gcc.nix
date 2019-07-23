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
, utillinux   # for `flock`
# "RV32IMAC" is the standard form of Piccolo's "RV32ACIMU"
, riscv-arch ? "rv32imac"
, targetLinux ? false
}:

# --------------------------
# RISC-V GCC Toolchain Setup

let
  riscv-toolchain-ver = "8.3.0";
  arch = riscv-arch;
  bits =
    if builtins.substring 0 4 arch == "rv32" then "32"
    else if builtins.substring 0 4 arch == "rv64" then "64"
    else abort "failed to recognize bit width of riscv architecture ${arch}";

in stdenv.mkDerivation rec {
  name    = "${triple}-${arch}-toolchain-${version}";
  version = "${riscv-toolchain-ver}-${builtins.substring 0 7 src.rev}";
  src     = fetchFromGitHub {
    owner  = "riscv";
    repo   = "riscv-gnu-toolchain";
    rev    = "afcc8bc655d30cf6af054ac1d3f5f89d0627aa79";
    sha256 = "101iyfc41rykcj73gsv0wbh6q55qbkc76xk3mviirxmz5bcsm90w";
    fetchSubmodules = true;
  };

  configureFlags   = [ "--with-arch=${arch}" "--with-cmodel=medany" ];
  makeFlags        = if targetLinux then [ "linux" ] else [];
  installPhase     = ":"; # 'make' installs on its own
  hardeningDisable = [ "all" ];
  enableParallelBuilding = true;

  # Stripping/fixups break the resulting libgcc.a archives, somehow.
  # Maybe something in stdenv that does this...
  dontStrip = true;
  dontFixup = true;

  nativeBuildInputs = [ curl gawk texinfo bison flex gperf utillinux ];
  buildInputs = [ libmpc mpfr gmp expat ];

  inherit arch;
  triple =
    if targetLinux then "riscv${bits}-unknown-linux-gnu"
    else "riscv${bits}-unknown-elf";
}
