{ lib
, stdenv
, freebsdWorld
, allowRootSSH ? true
}:

stdenv.mkDerivation rec {
  name = "freebsd-rootfs";

  src = freebsdWorld.out;

  buildInputs = [ freebsdWorld.tools ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  imageSize = "70m";

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

  '' + lib.optionalString allowRootSSH ''
    cat <<EOF >>etc/ssh/sshd_config
    PermitRootLogin yes
    EOF
  '' + ''
    makefs -N etc -D -f 10000 -o version=2 -s $imageSize riscv.img METALOG
  '';

  installPhase = ''
    cp riscv.img $out
  '';
}
