{ stdenv, fetchFromGitHub
, autoreconfHook, automake, pkgconfig, libftdi
}:

stdenv.mkDerivation rec {
  name    = "riscv-openocd-${version}";
  version = "${builtins.substring 0 7 src.rev}";
  src     = fetchFromGitHub {
    owner  = "riscv";
    repo   = "riscv-openocd";
    rev    = "35eed36ffdd082f5abfc16d4cc93511f6e225284";
    sha256 = "00b9jy3kq8y04yprzvf7f1cnvg4nqmplnipaqk7iawvan1mnddw8";
    fetchSubmodules = true;
  };

  configureFlags   = [
    "--enable-remote-bitbang"
    "--enable-jtag_vpi"
    "--disable-werror"
    "--enable-ftdi"
  ];
  hardeningDisable = [ "all" ];
  enableParallelBuilding = true;

  # Stripping/fixups break the resulting libgcc.a archives, somehow.
  # Maybe something in stdenv that does this...
  dontStrip = true;
  dontFixup = true;

  nativeBuildInputs = [ autoreconfHook automake pkgconfig ];
  buildInputs = [ libftdi ];
}
