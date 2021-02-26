{ stdenv, lib, qemu, zstd, chainloaderImage, callPackage
, useRsyslog ? true
, targetSsh ? null 
, extraSetup ? null
, buildDiskImage ? false }:

let
  extraSetupCp = if extraSetup != null then "cp ${extraSetup} virtfs/extra-setup.sh" else "";
  extraSetupArg = if extraSetup != null then "besspin.extra_setup=/mnt/extra-setup.sh" else "";
  diskImageArg = lib.optionalString buildDiskImage "besspin.rootfs_image=y";
  sshSetup = if targetSsh != null then "mkdir virtfs/ssh-riscv && cp -rf ${targetSsh}/* virtfs/ssh-riscv" else "";
  debianStage1VirtualDisk = callPackage ./debian-stage1-virtual-disk.nix { inherit useRsyslog; };
in stdenv.mkDerivation rec {
  name = if buildDiskImage then "debian-rootfs.img.zst" else "debian.cpio.gz";

  buildInputs = [ qemu zstd ];

  unpackPhase = "true";

  buildPhase = ''
    mkdir virtfs
    cp -rL ${debianStage1VirtualDisk}/* virtfs/
    ${extraSetupCp}
    ${sshSetup}

    # Set the clock in the VM to January 2020.  This is a workaround for an
    # expired key: the key used to sign the Debian Ports archive, as of the
    # snapshot we're using, expired on 2020-01-31.
    qemu-system-riscv64 \
      -nographic -machine virt -m 2G \
      -kernel ${chainloaderImage} \
      -append "console=ttyS0 besspin.set_clock=@$(date -d '2020-01-01' +%s) ${extraSetupArg} ${diskImageArg}" \
      -fsdev local,id=virtfs,path=$(pwd)/virtfs,security_model=mapped-file \
      -device virtio-9p-device,fsdev=virtfs,mount_tag=virtfs
  '';

  installPhase = if buildDiskImage then ''
    zstd virtfs/debian-rootfs.img -o debian-rootfs.img.zst
    cp debian-rootfs.img.zst $out
  '' else ''
    gzip -c --best <virtfs/debian-initramfs.cpio >debian-initramfs.cpio.gz
    cp debian-initramfs.cpio.gz $out
  '';
}
