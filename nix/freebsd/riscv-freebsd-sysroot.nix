{ stdenv }:

stdenv.mkDerivation rec {
  name = "riscv-freebsd-sysroot";
  src = ./sysroot.tar.gz;

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/sysroot
    cp -r usr lib $out/sysroot
  '';
}
