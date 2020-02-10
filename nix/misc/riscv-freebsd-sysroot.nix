{ stdenv }:

stdenv.mkDerivation rec {
  name = "riscv-freebsd-sysroot";

  src = fetchTarball {
    # We leave off the .tar.gz extension since otherwise Artifactory
    # will serve it with the Content-Encoding header set to 'x-gzip'
    # which Nix doesn't know how to handle.
    url = "https://artifactory.galois.com/besspin_generic-nix/freebsd-sysroot";
    sha256 = "0pyb6haq4mxfp73wyn01y120rz5qvi24kfqrkgrji6fmyflziwfv";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/sysroot
    cp -r usr lib $out/sysroot
  '';
}
