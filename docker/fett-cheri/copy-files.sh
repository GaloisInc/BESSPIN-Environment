#! /usr/bin/env bash
set -ex

sourceVariants=('-default' '-purecap' '-temporal')

mntPath=/mnt/cheridisk
sudo mkdir -p $mntPath

for sourceVariant in "${sourceVariants[@]}"; do
    targetSuffix=${sourceVariant%-default}
    kernel=./kernel-cheri${sourceVariant}.elf
    diskImage=./disk-image-cheri${sourceVariant}.img
    if [ ! -f ${kernel} ]; then
        cp ../../../BESSPIN-LFS/SRI-Cambridge/osImages/qemu/kernel-cheri${targetSuffix}.elf ${kernel}
    fi

    if [ ! -f ${diskImage}.zst ]; then
        cp ../../../BESSPIN-LFS/SRI-Cambridge/osImages/common/disk-image-cheri${targetSuffix}.img.zst ${diskImage}.zst
    fi

    if [ ! -d sysroot${sourceVariant} ]; then
        unzstd ${diskImage}.zst
        devLoop=$(sudo losetup -f --show -P ${diskImage})
        sudo mount -t ufs -o ufstype=ufs2,loop,ro ${devLoop}p1 $mntPath
        mkdir sysroot${sourceVariant}
        sudo cp -a $mntPath/lib $mntPath/usr sysroot${sourceVariant} 
        sudo umount $mntPath
        sudo losetup -d $devLoop
    fi
done
