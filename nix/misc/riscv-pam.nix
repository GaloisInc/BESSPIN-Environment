{stdenv
, fetchurl
, fetchpatch
, buildPackages
, overrideCC
, riscv-gcc-linux
, flex
, db4
, cracklib
}:
let
  stdenvRiscv = overrideCC stdenv riscv-gcc-linux;
in stdenvRiscv.mkDerivation rec {
  pname = "libpam";
  version = "1.3.1";

  patchPhase = "";

  src = fetchurl {
    url="https://github.com/linux-pam/linux-pam/releases/download/v1.3.1/Linux-PAM-${version}.tar.xz";
    sha256="1nyh9kdi3knhxcbv5v4snya0g3gff0m671lnvqcbygw3rm77mx7g";
  };

  outputs = [ "out" "doc" "man" /* "modules" */ ];

  postInstall = ''
    mv -v $out/sbin/unix_chkpwd{,.orig}
    ln -sv /run/wrappers/bin/unix_chkpwd $out/sbin/unix_chkpwd
  '';

    preConfigure = stdenv.lib.optionalString (stdenv.hostPlatform.libc == "musl") ''
      # export ac_cv_search_crypt=no
      # (taken from Alpine linux, apparently insecure but also doesn't build O:))
      # disable insecure modules
      # sed -e 's/pam_rhosts//g' -i modules/Makefile.am
      sed -e 's/pam_rhosts//g' -i modules/Makefile.in
  '';

  depsBuildBuild = [ buildPackages.stdenv.cc ];

    configureFlags = [
    "--includedir=${placeholder "out"}/include/security"
    "--enable-sconfigdir=/etc/security"
    "--host=riscv64-unknown-linux-gnu"
  ];

  installFlags = [
    "SCONFIGDIR=${placeholder "out"}/etc/security"
  ];

  buildInputs = [ cracklib db4 riscv-gcc-linux];


  nativeBuildInputs = [ flex ];

  doCheck = false; # fails
  enableParallelBuilding = true;

}
