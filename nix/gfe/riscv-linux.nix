{ stdenv, lib, gfeSrc, riscv-gcc-linux
, flex, bison, bc, libelf, openssl, perl
, configFile
, initramfs ? null
, kernelCmdline ? null
}:

let
  cpInitramfs = if initramfs == null
                then "sed -i 's/CONFIG_BLK_DEV_INITRD=y//g' .config"
                else "cp ${initramfs} initramfs.cpio.gz";
  modifyCmdline = lib.optionalString (kernelCmdline != null) ''
    sed -i 's%CONFIG_CMDLINE.*%CONFIG_CMDLINE="${kernelCmdline}"%' .config
  '';

in stdenv.mkDerivation rec {
  name = "riscv-linux";
  src = gfeSrc.modules.riscv-linux;

  buildInputs = [ riscv-gcc-linux flex bison bc libelf openssl perl ];

  configurePhase = ''
    cp ${configFile} .config
    ${cpInitramfs}
    ${modifyCmdline}
    make ARCH=riscv olddefconfig
  '';

  makeFlags = [ "ARCH=riscv" ];
  enableParallelBuilding = true;

  installPhase = ''
    cp vmlinux $out
  '';

  # fixupPhase normally does stuff like adjusting RPATHs and stripping
  # binaries, which we definitely don't want.
  fixupPhase = "";

  # Make the kernel build system use the riscv-gcc-linux toolchain.
  CROSS_COMPILE = "riscv64-unknown-linux-gnu-";

  passthru = {
    config = configFile;
    inherit initramfs;
  };
}
