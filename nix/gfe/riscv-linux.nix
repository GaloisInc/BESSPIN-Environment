{ stdenv, gfeSrc, riscv-gcc-64-linux
, flex, bison, bc, libelf, openssl, perl
, configFile
, initramfs ? null
}:

let
  cpInitramfs = if initramfs == null then "" else "cp ${initramfs} initramfs.cpio.gz";

in stdenv.mkDerivation rec {
  name = "riscv-linux";
  src = gfeSrc.modules.riscv-linux;

  buildInputs = [ riscv-gcc-64-linux flex bison bc libelf openssl perl ];

  configurePhase = ''
    cp ${configFile} .config
    ${cpInitramfs}
    make ARCH=riscv olddefconfig
  '';

  makeFlags = [ "ARCH=riscv" ];

  installPhase = ''
    cp vmlinux $out
  '';

  # fixupPhase normally does stuff like adjusting RPATHs and stripping
  # binaries, which we definitely don't want.
  fixupPhase = "";

  # Make the kernel build system use the riscv-gcc-64-linux toolchain.
  CROSS_COMPILE = "riscv64-unknown-linux-gnu-";
}
