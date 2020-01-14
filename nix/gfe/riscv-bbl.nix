{ stdenv, lib, gfeSrc, riscv-gcc
, payload ? null
, withQemuMemoryMap ? false
}:

stdenv.mkDerivation rec {
  name = "riscv-bbl";
  src = gfeSrc.modules.riscv-pk;

  buildInputs = [ riscv-gcc ];

  configurePhase = ''
    unset AR AS CC CXX LD OBJCOPY OBJDUMP RANLIB READELF SIZE STRINGS STRIP
    mkdir build
    cd build
    ../configure --host=riscv64-unknown-elf \
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
