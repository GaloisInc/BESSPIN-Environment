{ stdenv, lib, fetchFromGitHub, gfeSrc, riscv-gcc
, payload ? null
, gfePlatform ? "fpga"
}:

stdenv.mkDerivation rec {
  name = "riscv-bbl";
  src = if gfePlatform != "firesim" then
    gfeSrc.modules.riscv-pk
  else fetchFromGitHub {
    owner = "riscv";
    repo = "riscv-pk";
    rev = "8c125897999720856262f941396a9004b0ff5d3d";
    sha256 = "1cvk1xnnc0a3mddbdx1x1jmkv6p52vslq1930dnhp3hqhjki3p20";
  };

  buildInputs = [ riscv-gcc ];

  configurePhase = ''
    unset AR AS CC CXX LD OBJCOPY OBJDUMP RANLIB READELF SIZE STRINGS STRIP
    export CFLAGS="-nostdlib"
    export WITH_ARCH=rv64gc
    mkdir build
    cd build
    ../configure --host=riscv64-unknown-elf \
      ${if payload != null then "--with-payload=${payload}" else ""}
  '';

  makeFlags = lib.optional (gfePlatform == "qemu") "TARGET_QEMU=yes";

  patches = lib.optional (gfePlatform == "firesim") ./riscv-pk-firesim-uart.patch;

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
