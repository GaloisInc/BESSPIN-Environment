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
, targetLinux ? false
}:

# --------------------------
# RISC-V GCC Toolchain Setup

let
  riscv-toolchain-ver = "9.2.0";

in stdenv.mkDerivation rec {
  name    = "${triple}-${arch}-toolchain-${version}";
  version = "${riscv-toolchain-ver}-${builtins.substring 0 7 src.rev}";
  src     = fetchFromGitHub {
    owner  = "riscv";
    repo   = "riscv-gnu-toolchain";
    rev    = "2855d823a6e93d50af604264b02ced951e80de67";
    sha256 = "1dy3gks8ansn3770zkny5cqkr6xk8chpz1c7vjpvx980z0bzqjiy";
    fetchSubmodules = true;
  };

  # The multilib build can also target 32-bit binaries, but is labeled 64.
  # The default "rv64gc" arch string includes all standard extensions.
  configureFlags   = [ "--enable-multilib" ];
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
    if targetLinux then "riscv64-unknown-linux-gnu"
    else "riscv64-unknown-elf";
}
