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

{ stdenv, fetchFromGitHub, assembleSubmodules
, curl, gawk, texinfo, bison, flex, gperf
, libmpc, mpfr, gmp, expat
, utillinux   # for `flock`
, targetLinux ? false
}:

# --------------------------
# RISC-V GCC Toolchain Setup

let
  riscv-toolchain-ver = "9.2.0";

  fetch = owner: repo: rev: sha256: fetchFromGitHub {
    inherit owner repo rev sha256;
  };

  fetchRiscv = name: rev: sha256: fetch "riscv" ("riscv-" + name) rev sha256;

  # Manually assemble submodules to avoid running `git` inside the builder.
  # That causes problems on some setups, as seen in tool-suite#93.
  src = assembleSubmodules {
    name = "riscv-gcc-src";
    modules = {
      "." = fetchRiscv "gnu-toolchain" "afcc8bc655d30cf6af054ac1d3f5f89d0627aa79"
        "101iyfc41rykcj73gsv0wbh6q55qbkc76xk3mviirxmz5bcsm90w";
      "riscv-binutils" = fetchRiscv "binutils-gdb" "a9d9a104dde6a749f40ce5c4576a0042a7d52d1f"
        "0l1520zcf9q4wdhx1h0alsf6vxns2a718brs9qkbnp3rpg898xi6";
      "riscv-dejagnu" = fetchRiscv "dejagnu" "2e99dc08d8e5e16f07627bd52a192906abfa9a5c"
        "0qqw8nsa66hyibh5p6gzlkv8g53rh6jpqi0gp860fdnn4bz9dpb5";
      "riscv-gcc" = fetchRiscv "gcc" "8fb74cd00216817f5d1613e491fdde163aca65bc"
        "0325vwgpnwag4cbv5jjl7f2msyf4c948f9xvq2wyh4hdw4dd4vcw";
      "riscv-gdb" = fetchRiscv "binutils-gdb" "044a7fdd5d0e6f3a4fc60e43673368e387c4b753"
        "1k08rzmybpc3lmxj81rdi30a4blxvv1q2xalsiys1g6dz1s5lrab";
      "riscv-glibc" = fetchRiscv "glibc" "2f626de717a86be3a1fe39e779f0b179e13ccfbb"
        "0ydxy2v99k1barnm2b6nzgh681czmqhzbrclrb606nl37mg098sw";
      "riscv-newlib" = fetchRiscv "newlib" "320b28ea27c71df7afe62b21a220f77aef9eb88a"
        "1zmiajfi3l7gzys2z49cin8pr3ycwnx7v0vqdra5dxac0lwcn3w7";
      "riscv-qemu" = fetchRiscv "qemu" "ff36f2f77ec3e6a6211c63bfe1707ec057b12f7d"
        "1p0l437767iwyg7jwhgvi87hbqz6a5yhdfr72p0pxch0rv30q4wb";
    };
  };

in stdenv.mkDerivation rec {
  name    = "${triple}-${arch}-toolchain-${version}";
  version = "${riscv-toolchain-ver}-${builtins.substring 0 7 src.modules.".".rev}";
  inherit src;

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
