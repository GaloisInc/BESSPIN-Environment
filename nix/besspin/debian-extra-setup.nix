{ stdenv, lib, writeTextFile, gfePlatform ? null }:

writeTextFile {
  name = "extra-setup";
  executable = true;
  text = ''
    #!/bin/sh

    echo "Installing FETT OpenSSH"
    cp -rf /mnt/ssh-riscv/bin/* /usr/bin
    cp -rf /mnt/ssh-riscv/sbin/* /usr/sbin
    cp -rf /mnt/ssh-riscv/var /var

    cp /mnt/zlib-riscv/lib/libz.so.1.2.11 /lib/libz.so.1
    cp /mnt/zlib-riscv/lib/libz.a /lib/libz.a

    cp /mnt/ssh-riscv/config/ssh_config /etc/ssh
    cp /mnt/ssh-riscv/config/sshd_config /etc/ssh

    if [ -f /etc/securetty ]; then
      echo "Enabling root login via ttySIF0."
      echo ttySIF0 >> /etc/securetty
    fi
  '' + lib.optionalString (gfePlatform == "firesim") ''
    echo "GFE platform is FireSim. Masking OpenSSH."
    systemctl mask ssh.service
  '' + lib.optionalString (gfePlatform != "firesim") ''
    echo "Removing SBI console"
    ln -sf /dev/null /etc/systemd/system/serial-getty@hvc0.service
  '';
}
