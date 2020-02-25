{
  gccPkg
  , riscv-libpam
  , riscv-libkeyutils
  , makeWrapper
  , runCommand 
}:
let
  flags = "-L${riscv-libpam}/lib -L${riscv-libkeyutils}/lib -I${riscv-libpam}/include -I${riscv-libkeyutils}/include";
# See https://nixos.wiki/wiki/Nix_Cookbook#Wrapping_packages
in runCommand "riscv64-unknown-linux-gnu-gcc" {
  buildInputs = [ makeWrapper ];
} ''
  mkdir $out
  ln -s ${gccPkg}/* $out
  rm $out/bin
  mkdir $out/bin
  ln -s ${gccPkg}/bin/* $out/bin
  rm $out/bin/riscv64-unknown-linux-gnu-gcc $out/bin/riscv64-unknown-linux-gnu-g++
  makeWrapper ${gccPkg}/bin/riscv64-unknown-linux-gnu-gcc $out/bin/riscv64-unknown-linux-gnu-wrapped-gcc \
  --add-flags "${flags}"
  makeWrapper ${gccPkg}/bin/riscv64-unknown-linux-gnu-gcc $out/bin/riscv64-unknown-linux-gnu-wrapped-g++ \
  --add-flags "${flags}"
''
