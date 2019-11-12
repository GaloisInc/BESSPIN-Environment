{ stdenv, qemu, chainloaderImage, debianStage1VirtualDisk
, extraSetup ? null }:

let
  extraSetupCp = if extraSetup != null then "cp ${extraSetup} virtfs/extra-setup.sh" else "";
  extraSetupArg = if extraSetup != null then "besspin.extra_setup=/mnt/extra-setup.sh" else "";
in stdenv.mkDerivation rec {
  name = "debian.cpio.gz";

  buildInputs = [ qemu ];

  unpackPhase = "true";

  buildPhase = ''
    mkdir virtfs
    cp -rL ${debianStage1VirtualDisk}/* virtfs/
    ${extraSetupCp}

    qemu-system-riscv64 \
      -nographic -machine virt -m 2G \
      -kernel ${chainloaderImage} \
      -append "console=ttyS0 besspin.set_clock=@$(date +%s) ${extraSetupArg}" \
      -fsdev local,id=virtfs,path=$(pwd)/virtfs,security_model=mapped-file \
      -device virtio-9p-device,fsdev=virtfs,mount_tag=virtfs

    gzip -c --best <virtfs/debian-initramfs.cpio >debian-initramfs.cpio.gz
  '';

  installPhase = ''
    cp debian-initramfs.cpio.gz $out
  '';
}