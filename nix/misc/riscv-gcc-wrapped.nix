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
  mkdir -p $out/bin
  makeWrapper ${gccPkg}/bin/riscv64-unknown-linux-gnu-gcc $out/bin/riscv64-unknown-linux-gnu-wrapped-gcc \
  --add-flags "${flags}"
  makeWrapper ${gccPkg}/bin/riscv64-unknown-linux-gnu-g++ $out/bin/riscv64-unknown-linux-gnu-wrapped-g++ \
  --add-flags "${flags}"
  makeWrapper ${gccPkg}/bin/riscv64-unknown-linux-gnu-ld $out/bin/riscv64-unknown-linux-gnu-wrapped-ld \
  --add-flags "${flags}"
''
