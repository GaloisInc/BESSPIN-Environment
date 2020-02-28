# this library must match the libraries specified in nix/misc/debian-repo-files.json
# the version packages here can’t be any newer than in the Debian libraries
{ stdenv
 , overrideCC
 , riscv-gcc-linux
 , linux-pam
}:
let
  stdenvRiscv = overrideCC stdenv riscv-gcc-linux;
in (linux-pam.override { 
  stdenv = stdenvRiscv; }).overrideAttrs (old : {
    # Patches and Outputs need to be modified for the changed stdenv
    patchPhase = "";
    outputs = [ "out" ];
    # Add host for cross compilation 
    configureFlags = [
      "--includedir=${placeholder "out"}/include/security"
      "--enable-sconfigdir=/etc/security"
      "--host=riscv64-unknown-linux-gnu"
    ];
    # required -- fails otherwise
    installFlags = [
      "SCONFIGDIR=${placeholder "out"}/etc/security"
    ];
  })
