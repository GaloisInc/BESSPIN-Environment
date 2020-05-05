{ stdenv, qemu, chainloaderImage, debianStage1VirtualDisk
, targetSsh ? null 
, targetZlib ? null
, extraSetup ? null }:

let
  extraSetupCp = if extraSetup != null then "cp ${extraSetup} virtfs/extra-setup.sh" else "";
  extraSetupArg = if extraSetup != null then "besspin.extra_setup=/mnt/extra-setup.sh" else "";
  zlibSetup = if targetZlib != null then "mkdir virtfs/zlib-riscv && cp -rf ${targetZlib}/* virtfs/zlib-riscv" else "";
  sshSetup = if targetSsh != null then "mkdir virtfs/ssh-riscv && cp -rf ${targetSsh}/* virtfs/ssh-riscv" else "";
in stdenv.mkDerivation rec {
  name = "debian.cpio.gz";

  buildInputs = [ qemu ];

  unpackPhase = "true";

  buildPhase = ''
    mkdir virtfs
    cp -rL ${debianStage1VirtualDisk}/* virtfs/
    ${extraSetupCp}
    ${zlibSetup}
    ${sshSetup}

    # Set the clock in the VM to January 2020.  This is a workaround for an
    # expired key: the key used to sign the Debian Ports archive, as of the
    # snapshot we're using, expired on 2020-01-31.
    qemu-system-riscv64 \
      -nographic -machine virt -m 2G \
      -kernel ${chainloaderImage} \
      -append "console=ttyS0 besspin.set_clock=@$(date -d '2020-01-01' +%s) ${extraSetupArg}" \
      -fsdev local,id=virtfs,path=$(pwd)/virtfs,security_model=mapped-file \
      -device virtio-9p-device,fsdev=virtfs,mount_tag=virtfs

    gzip -c --best <virtfs/debian-initramfs.cpio >debian-initramfs.cpio.gz
  '';

  installPhase = ''
    cp debian-initramfs.cpio.gz $out
  '';
}
