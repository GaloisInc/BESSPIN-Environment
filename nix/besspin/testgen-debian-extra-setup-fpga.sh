#!/bin/sh
cp -rf /mnt/ssh-riscv/bin/* /usr/bin
cp -rf /mnt/ssh-riscv/sbin/* /usr/sbin
cp -rf /mnt/ssh-riscv/var /var

cp /mnt/zlib-riscv/lib/libz.so.1.2.11 /lib/libz.so.1
cp /mnt/zlib-riscv/lib/libz.a /lib/libz.a

cp /mnt/ssh-riscv/config/ssh_config /etc/ssh
cp /mnt/ssh-riscv/config/sshd_config /etc/ssh
