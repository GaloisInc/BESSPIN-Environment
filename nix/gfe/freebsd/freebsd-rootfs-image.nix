{ lib
, stdenv
, python3
, device
, freebsdWorld
, userspacePrograms
, allowRootSSH ? true
, defaultRootPassword ? null
}:

stdenv.mkDerivation rec {
  name = "freebsd-rootfs";

  src = freebsdWorld.out;

  buildInputs = [ python3 freebsdWorld.tools ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  imageSize = "75m";

  fstab = ./fstab;
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
  '' + lib.optionalString (device == "FPGA") ''
    echo 'ifconfig_xae0="inet 10.88.88.2/24"' >>etc/rc.conf
  '' + ''
      cp -rf ${userspacePrograms.ssh}/sbin/* ./usr/sbin/
      cp -rf ${userspacePrograms.ssh}/bin/* ./usr/bin/
      cp -rf ${userspacePrograms.ssh}/var ./var/

      ls ${userspacePrograms.zlib}/lib 
      cp ${userspacePrograms.zlib}/lib/libz.so.1.2.11 ./lib/libz.so.1
      cp ${userspacePrograms.zlib}/lib/libz.a ./lib/libz.a
      
      cat <<EOF >>METALOG
        ./lib/libz.so.1 type=file uname=root gname=wheel mode=0755
      EOF
  '' + ''
    makefs -N etc -D -f 10000 -o version=2 -s $imageSize riscv.img METALOG
  '';

  installPhase = ''
    cp riscv.img $out
  '';
}
