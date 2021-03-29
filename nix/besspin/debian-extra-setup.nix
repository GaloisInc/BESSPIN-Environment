{ stdenv, lib, writeTextFile, gfePlatform ? null, rootDeviceName ? null }:

writeTextFile {
  name = "extra-setup";
  executable = true;
  text = ''
    #!/bin/sh
    set -e

    echo "Installing BESSPIN OpenSSH"
    cp -f /mnt/ssh-riscv/bin/* /usr/bin
    cp -f /mnt/ssh-riscv/sbin/* /usr/sbin
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

    if [ -f /etc/securetty ]; then
      echo "Enabling root login via ttySIF0."
      echo ttySIF0 >> /etc/securetty
    fi

  '' + lib.optionalString (gfePlatform != "fpga") ''
    echo "Installing extra packages for BESSPIN"

    apt-get install -y libpython3.7 binutils build-essential bzip2 dnsmasq \
      emacs file gzip lynx mosh nano openssl p7zip patch perl python3 rsync \
      screen tmux wget zip xz-utils graphicsmagick git libtiff-tools \
      libexif-dev libfreeimage3 curl tcpdump ghostscript sudo imagemagick

    dpkg -i /mnt/pkgs/libreadline.deb
    dpkg -i /mnt/pkgs/gdb.deb
    dpkg -i /mnt/pkgs/strace.deb

  '' + lib.optionalString (gfePlatform == "firesim") ''
    apt-get install -y rng-tools
  '' + lib.optionalString (rootDeviceName != null) ''
    cat <<EOF >/etc/fstab
    /dev/${rootDeviceName}        /       ext4    defaults        0       1
    EOF

    # The GFE scripts mask fstrim.service. We should also mask the
    # timer, or else we will get an error message. This only happens
    # when the root filesystem is mounted on a "real" disk instead of
    # the initramfs.
    systemctl mask fstrim.timer
  '';
}
