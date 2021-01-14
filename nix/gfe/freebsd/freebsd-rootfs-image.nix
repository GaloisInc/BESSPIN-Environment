{ lib
, stdenv
, writeTextFile
, python3
, gfePlatform
, zstd
, freebsdWorld
, targetSsh ? null
, allowRootSSH ? true
, defaultRootPassword ? null
, compressImage ? false
, imageSize ? "85m" # If makefs fails, it may be necessary to increase
                    # the size of the image
, targetGdb ? null
}:

let mkfstab = rootdev:
      writeTextFile {
        name = "freebsd-fstab";
        text = ''
          /dev/${rootdev}        /       ufs     rw      0       1
        '';
      };
in stdenv.mkDerivation rec {
  name = "freebsd-rootfs";

  src = freebsdWorld.out;

  buildInputs = [ python3 freebsdWorld.tools zstd ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  inherit imageSize;

  fstab = if gfePlatform == "connectal" then mkfstab "vtbd0" else ./fstab;
  exclude = ./exclude;

  buildPhase = ''
    sed -i -E 's/time=[0-9\.]+$//' METALOG
    grep -E -v -f $exclude METALOG > METALOG.new
    mv METALOG.new METALOG

    mkdir -p home

    cat <<EOF >etc/rc.conf
    hostname="gfe"
    sshd_enable="YES"
    EOF

    cp $fstab etc/fstab

    cat <<EOF >>METALOG
    ./etc/fstab type=file uname=root gname=wheel mode=0644
    ./etc/rc.conf type=file uname=root gname=wheel mode=0644
    ./home type=dir uname=root gname=wheel mode=0755
    EOF
  '' + lib.optionalString (defaultRootPassword != null) ''
    PWHASH=$(python3 -c 'import crypt, sys; print(crypt.crypt(sys.argv[1], "$6$ssith"))' \
      ${lib.escapeShellArg defaultRootPassword} \
      | sed 's_[/$]_\\&_g')

    sed -i -E "s/^(root:)[^:]*/\1$PWHASH/" etc/master.passwd
    pwd_mkdb -d etc etc/master.passwd
  '' + lib.optionalString allowRootSSH ''
    cat <<EOF >>etc/ssh/sshd_config
    PermitRootLogin yes
    EOF
  '' + lib.optionalString (gfePlatform == "fpga") ''
    echo 'ifconfig_xae0="inet XXX.XXX.XXX.XXX/24"' >>etc/rc.conf
  '' + lib.optionalString (targetSsh != null) ''
      cp -rf ${targetSsh}/sbin/* ./usr/sbin/
      cp -rf ${targetSsh}/bin/* ./usr/bin/
      cp -rf ${targetSsh}/var ./var/
      cat <<EOF >>etc/ssh/sshd_config
      HostKey /etc/ssh/ssh_host_rsa_key
      HostKey /etc/ssh/ssh_host_ecdsa_key
      HostKey /etc/ssh/ssh_host_ed25519_key
      EOF

      # ./lib/libz.so.1 type=file uname=root gname=wheel mode=0755
  '' + lib.optionalString (targetGdb != null) ''
      install ${targetGdb} /usr/local/sbin/gdb
  '' + ''
    makefs -N etc -D -f 10000 -o version=2 -s $imageSize riscv.img METALOG
  '';

  installPhase = if compressImage then ''
    zstd riscv.img -o riscv.img.zst
    cp riscv.img.zst $out
  '' else ''
    cp riscv.img $out
  '';
}
