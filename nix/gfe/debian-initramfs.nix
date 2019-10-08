{ stdenv, qemu, chainloaderImage, debianStage1VirtualDisk }:

stdenv.mkDerivation rec {
  name = "debian.cpio.gz";
  # Copy virtual disk contents into the build directory, so that QEMU will be
  # able to write the newly created debian.cpio.gz into it.
  src = debianStage1VirtualDisk;

  buildInputs = [ qemu ];

  buildPhase = ''
    qemu-system-riscv64 \
      -nographic -machine virt -m 1G \
      -kernel ${chainloaderImage} -append 'console=ttyS0' \
      -drive file=fat:rw:$(pwd),format=raw,id=hd0 \
      -device virtio-blk-device,drive=hd0
    gzip -c --best <debian-initramfs.cpio >debian-initramfs.cpio.gz
  '';

  installPhase = ''
    cp debian-initramfs.cpio.gz $out
  '';
}
