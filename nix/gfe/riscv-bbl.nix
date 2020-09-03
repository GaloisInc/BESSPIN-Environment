{ stdenv, lib, fetchFromGitHub, gfeSrc, riscv-gcc
, payload ? null
, gfePlatform ? "fpga"
}:

stdenv.mkDerivation rec {
  name = "riscv-bbl";
  src = gfeSrc.modules."riscv-pk";

  buildInputs = [ riscv-gcc ];

  configurePhase = ''
    unset AR AS CC CXX LD OBJCOPY OBJDUMP RANLIB READELF SIZE STRINGS STRIP
    export CFLAGS="-nostdlib"
    export WITH_ARCH=rv64gc
    mkdir build
    cd build
    ../configure --host=riscv64-unknown-elf \
      --enable-zero-bss \
      ${lib.optionalString (payload != null) "--with-payload=${payload}"} \
      --with-mem-start=${if gfePlatform == "qemu" then "0x80000000" else "0xC0000000"}
  '';

  makeFlags = lib.optional (gfePlatform == "qemu") "TARGET_QEMU=yes";

  patches = lib.optional (gfePlatform == "firesim") [ 
      ./riscv-pk-firesim-uart.patch
      ./riscv-pk-firesim-poweroff.patch
      ];

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
