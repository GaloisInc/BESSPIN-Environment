# Cross-compiles OpenSSL v1.1.1c

{ stdenv, fetchgit, riscv-gcc-linux, perl, buildPackages }:

let
  riscvPrefix = "${riscv-gcc-linux}/bin/riscv64-unknown-linux-gnu-";

in stdenv.mkDerivation {
  pname = "openssl";
  version = "1.1.1c";
  
  out = ["out"];

  # the version referred to in nix/misc/debian-repo-files.json
  src = fetchgit {
    url="https://github.com/openssl/openssl";
    rev="97ace46e11dba4c4c2b7cb67140b6ec152cfaaf4";
    sha256="0qprjcbrkfn9dy4sdfw587md30g1jdys8xhx0x1cxb6b9b0b228h";
    fetchSubmodules= false;
  };

  # No support for riscv64, but generic is good enough
  configureScript = '' ./Configure linux-generic64 '';

  configureFlags    = [ "--cross-compile-prefix=${riscvPrefix}" "--openssldir=${placeholder "out"}"];

  # No need for any of this
  enableParallelBuilding = false;
  makeFlags = [];
  buildInputs = [];
  dontFixup = true;

  # Shebang Shenanigans
  postPatch = ''
    substituteInPlace Configure --replace '/usr/bin/env perl' '${perl}/bin/perl'
  '';
  
  # Copied from https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/libraries/openssl/default.nix
  postInstall = ''
    substituteInPlace $out/bin/c_rehash --replace ${buildPackages.perl} ${perl}
  '';

  CC      = "${riscvPrefix}gcc -march=rv64imafdc -mabi=lp64d -Wall -lrt -fPIC";
  AR      = "${riscvPrefix}ar";
  RANLIB  = "${riscvPrefix}ranlib";
  STRIP   = "${riscvPrefix}strip";
}