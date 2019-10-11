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
      "." = fetchRiscv "gnu-toolchain" "2855d823a6e93d50af604264b02ced951e80de67"
        "1dy3gks8ansn3770zkny5cqkr6xk8chpz1c7vjpvx980z0bzqjiy";
      # QEMU submodule is omitted.  It's very large, and not necessary.
      "riscv-binutils" = fetchRiscv "binutils-gdb" "d91cadb45f3ef9f96c6ebe8ffb20472824ed05a7"
        "00i1inzq81zmrmxzxbgz6y999ql7yf6w417ldrf445fn9b7i15vy";
      "riscv-dejagnu" = fetchRiscv "dejagnu" "4ea498a8e1fafeb568530d84db1880066478c86b"
        "1sivq3gr46mgvmxs7kdcgnz5yqkah1c101wm0rsa6d3lr4s35zy7";
      "riscv-gcc" = fetchRiscv "gcc" "b6cdb9a9f5eb1c4ae5b7769d90a79f29853a0fe2"
        "0w606k3kvg8pkrk0l33wlrnx6llhniz3sm3bzn9mm73ah4gb82dh";
      "riscv-gdb" = fetchRiscv "binutils-gdb" "c3eb4078520dad8234ffd7fbf893ac0da23ad3c8"
        "0r1gb98ykk8nzh3ijg4gc6qng36w9y9dlvldgx95l83vi0f1rwbx";
      "riscv-glibc" = fetchRiscv "glibc" "06983fe52cfe8e4779035c27e8cc5d2caab31531"
        "1cw4lykkgajpja8pcwd4ssxsxvdc6l3r2wzv1zch06h07pawqjs9";
      "riscv-newlib" = fetchRiscv "newlib" "0d24a86822a5ee73d6a6aa69e2a0118aa1e35204"
        "0r56ap9vpghawcbviw5bzzvkfdg1z9cissxzl37m1r3wjv15ncmf";
    };
  };

in stdenv.mkDerivation rec {
  name    = "${triple}-toolchain-${version}";
  version = "${riscv-toolchain-ver}-${builtins.substring 0 7 src.modules.".".rev}";
  inherit src;

  # The multilib build can also target 32-bit binaries, but is labeled 64.
  # The default "rv64gc" arch string includes all standard extensions.
  configureFlags   = [ "--enable-multilib" "--with-cmodel=medany"];
  makeFlags        = if targetLinux then [ "linux" ] else [];
  installPhase     = ":"; # 'make' installs on its own
  hardeningDisable = [ "all" ];
  enableParallelBuilding = true;

  # Stripping/fixups break the resulting libgcc.a archives, somehow.
  # Maybe something in stdenv that does this...
  dontStrip = true;
  dontFixup = true;

  nativeBuildInputs = [ curl gawk texinfo bison flex gperf python3 utillinux ];
  buildInputs = [ libmpc mpfr gmp expat ];

  triple =
    if targetLinux then "riscv64-unknown-linux-gnu"
    else "riscv64-unknown-elf";
}
