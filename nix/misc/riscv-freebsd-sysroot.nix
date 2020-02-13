{ stdenv }:

stdenv.mkDerivation rec {
  name = "riscv-freebsd-sysroot";

  src = fetchTarball {
    url = "http://localhost:8000/freebsd-sysroot";
    sha256 = "0pyb6haq4mxfp73wyn01y120rz5qvi24kfqrkgrji6fmyflziwfv";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/sysroot
    cp -r usr lib $out/sysroot
  '';
}
