{ stdenv, fetchFromGitHub
, autoreconfHook, automake, pkgconfig, libftdi
}:

stdenv.mkDerivation rec {
  name    = "riscv-openocd-${version}";
  version = "${builtins.substring 0 7 src.rev}";
  src     = fetchFromGitHub {
    owner  = "riscv";
    repo   = "riscv-openocd";
    rev    = "eb7af6cba0b42ea6d0990f4360a32ca90b7902fb";
    sha256 = "1zc8l55pkndm4q8cmhq2haa01f1plhqc3smx5pa7p7gglzhnyl0v";
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
