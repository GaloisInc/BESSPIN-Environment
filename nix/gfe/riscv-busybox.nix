{ stdenv, gfeSrc, riscv-gcc-64-linux
, configFile
}:

stdenv.mkDerivation rec {
  name = "riscv-busybox";
  src = gfeSrc.modules.busybox;

  buildInputs = [ riscv-gcc-64-linux ];

  configurePhase = ''
    cp ${configFile} .config
    make oldconfig
  '';

  installPhase = ''
    make install
    cp -a _install $out
  '';

  # fixupPhase normally does stuff like adjusting RPATHs and stripping
  # binaries, which we definitely don't want.
  fixupPhase = "";

  # Make the Busybox build system use the riscv-gcc-64-linux toolchain.
  CROSS_COMPILE = "riscv64-unknown-linux-gnu-";

  # -Werror=format-security causes problems for some parts of the build
  hardeningDisable = [ "format" ];

  passthru = {
    config = configFile;
  };
}
