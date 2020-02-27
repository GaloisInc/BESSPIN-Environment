{ freebsdWorld
, stdenv
}:

stdenv.mkDerivation rec {
  name = "freebsd-rootfs";

  src = freebsdWorld.out;

  buildInputs = [ freebsdWorld.tools ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  imageSize = "110m";

  fstab = ./fstab;

  buildPhase = ''
    sed -i -E 's/time=[0-9\.]+$//' METALOG
    egrep -v "usr/lib/[^ ]*\\.a|usr/share/i18n|^./var/" METALOG > METALOG.new
    mv METALOG.new METALOG

    mkdir -p home

    echo 'hostname="gfe"' > etc/rc.conf
    cp $fstab etc/fstab

    cat <<EOF >>METALOG
    ./etc/fstab type=file uname=root gname=wheel mode=0644
    ./etc/rc.conf type=file uname=root gname=wheel mode=0644
    ./home type=dir uname=root gname=wheel mode=0755
    EOF

    makefs -N etc -D -f 10000 -o version=2 -s $imageSize riscv.img METALOG
  '';

  installPhase = ''
    cp riscv.img $out
  '';
}
