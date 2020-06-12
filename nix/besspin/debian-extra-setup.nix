{ stdenv, lib, writeTextFile, gfePlatform ? null }:

writeTextFile {
  name = "extra-setup";
  executable = true;
  text = ''
    #!/bin/sh

    echo "Installing FETT OpenSSH"
    cp -f /mnt/ssh-riscv/bin/* /usr/sbin
    mkdir /var/empty
    cp /mnt/ssh-riscv/config/ssh_config /etc/ssh
    cp /mnt/ssh-riscv/config/sshd_config /etc/ssh

    # Be specific about the host keys, otherwise sshd will try to load
    # ssh_host_key_dsa which isn't there.
    cat <<EOF >>/etc/ssh/sshd_config
    HostKey /etc/ssh/ssh_host_rsa_key
    HostKey /etc/ssh/ssh_host_ecdsa_key
    HostKey /etc/ssh/ssh_host_ed25519_key
    EOF

    # The version of OpenSSH in debian is patched to use sd_notify, but ours isn't.
    sed -i 's/Type=notify/Type=simple/' /lib/systemd/system/ssh.service

    cp /mnt/zlib-riscv/lib/libz.so.1.2.11 /lib/libz.so.1
    cp /mnt/zlib-riscv/lib/libz.a /lib/libz.a

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
