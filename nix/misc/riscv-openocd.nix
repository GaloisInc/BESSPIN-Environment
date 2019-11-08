{ stdenv, lib, fetchGit2
, autoreconfHook, automake, pkgconfig, libftdi
}:

let
  modules = {
    "." = fetchGit2 {
      url = "git@gitlab-ext.galois.com:ssith/riscv-openocd.git";
      rev = "27c0fd7a7504087e6d8b6158a149b531bda9260d";
      ref = "gfe";
    };
    "jimtcl" = fetchGit2 {
      url = "https://github.com/msteveb/jimtcl.git";
      rev = "51f65c6d38fbf86e1f0b036ad336761fd2ab7fa0";
    };
  };

  src = stdenv.mkDerivation rec {
    name = "riscv-openocd-src";
    phases = [ "installPhase" ];
    installPhase =
      lib.concatMapStrings (dest:
        let
          src = builtins.getAttr dest modules;
        in ''
          mkdir -p $out/${dest}
          cp -r ${src}/* $out/${dest}/
          chmod -R u+w $out/${dest}
        '') (builtins.attrNames modules);

    rev = modules.".".rev;
  };

in stdenv.mkDerivation rec {
  name    = "riscv-openocd-${version}";
  version = "${builtins.substring 0 7 src.rev}";
  inherit src;

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

