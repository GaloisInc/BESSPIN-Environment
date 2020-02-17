{ stdenv, lib, gfeSrc, riscv-gcc
, payload ? null
, withQemuMemoryMap ? false
, host ? "riscv64-unknown-elf"
, configureArgs ? []
}:

stdenv.mkDerivation rec {
  inherit configureArgs; 

  name = "riscv-bbl";
  src = gfeSrc.modules.riscv-pk;

  buildInputs = [ riscv-gcc ];

  configurePhase = ''
    unset AR AS CC CXX LD OBJCOPY OBJDUMP RANLIB READELF SIZE STRINGS STRIP
    export CFLAGS="-nostdlib"
    export WITH_ARCH=rv64gc
    mkdir build
    cd build
    ../configure --host=${host} $configureArgs \
      ${if payload != null then "--with-payload=${payload}" else ""}
  '';

  makeFlags = lib.optional withQemuMemoryMap "TARGET_QEMU=yes";

  installPhase = ''
    cp bbl $out
  '';

  # fixupPhase normally does stuff like adjusting RPATHs and stripping
  # binaries, which we definitely don't want.
  fixupPhase = "";

  passthru = {
    inherit payload;
  };
}
