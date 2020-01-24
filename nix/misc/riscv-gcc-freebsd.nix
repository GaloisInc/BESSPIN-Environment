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
, curl, gawk, texinfo, bison, flex, gperf, python3
, libmpc, mpfr, gmp, expat
, utillinux   # for `flock`
, targetLinux ? false
, besspinConfig
}:

# --------------------------
# RISC-V GCC Toolchain Setup

let
  riscv-toolchain-ver = "9.2.0";

  fetch = owner: repo: rev: sha256: fetchFromGitHub {
    inherit owner repo rev sha256;
  };

  fetchRiscv = name: rev: sha256: fetch "freebsd-riscv" ("riscv-" + name) rev sha256;

  # Manually assemble submodules to avoid running `git` inside the builder.
  # That causes problems on some setups, as seen in tool-suite#93.
  defaultSrc = assembleSubmodules {
    name = "riscv-gcc-src";
    modules = {
      "." = fetchRiscv "gnu-toolchain" "1505830a3b757b3e65c15147388dd1a91ee2c786"
        "0ljamakfdh5d3v1k5r6zm99f40z7ij58q3cswssdjq4rzlvpi0hf";
      # QEMU submodule is omitted.  It's very large, and not necessary.
      "riscv-binutils" = fetchRiscv "binutils-gdb" "82dcb8613e1b1fb2989deffde1d3c9729695ff9c"
        "1b36m3vn9l1wxz62whk8wc7mrg27iadqd1rsy13yfzwr4s9zby7f";
      "riscv-gcc" = fetchRiscv "gcc" "be9abee2aaa919ad8530336569d17b5a60049717"
        "16cfb7zqy9vygawl82vnzixa8vasnii5v6bzj6m5awjk3dcrcrnc";
      "riscv-gdb" = fetchRiscv "binutils-gdb" "c3eb4078520dad8234ffd7fbf893ac0da23ad3c8"
        "0r1gb98ykk8nzh3ijg4gc6qng36w9y9dlvldgx95l83vi0f1rwbx";
    };
  };

  src = besspinConfig.customize.gnuToolchainSrc or defaultSrc;
  rev = if besspinConfig ? customize.gnuToolchainSrc then "0000000"
    else builtins.substring 0 7 src.modules.".".rev;

in stdenv.mkDerivation rec {
  name    = "${triple}-toolchain-${version}";
  version = "${riscv-toolchain-ver}-${rev}";
  inherit src;

  makeFlags        = [ "freebsd" "OSREL=${freebsd-version}" ];
  installPhase     = ":"; # 'make' installs on its own
  hardeningDisable = [ "all" ];
  enableParallelBuilding = true;

  # Stripping/fixups break the resulting libgcc.a archives, somehow.
  # Maybe something in stdenv that does this...
  dontStrip = true;
  dontFixup = true;

  nativeBuildInputs = [ curl gawk texinfo bison flex gperf python3 utillinux ];
  buildInputs = [ libmpc mpfr gmp expat ];

  freebsd-version = "12.1";
  triple = "riscv64-unknown-freebsd${freebsd-version}";
}
