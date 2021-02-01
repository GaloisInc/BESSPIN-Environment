{ stdenv
, sysroot
, crossPrefix
, fetchurl
, zstd
}:

stdenv.mkDerivation rec {
    pname = "${crossPrefix}-gdb";
    version = "8.3";

    src = fetchurl {
        url="https://people.freebsd.org/~brooks/stuff/gdb-freebsd-riscv64-static.zst";
        sha256="0p4di64d7zjk162brs0ykidik65rv4r037s7bx1h1pvcxlb5a1a7";
    };

    buildInputs = [ zstd ];

    phases = [ "unpackPhase" ];

    unpackPhase = ''
        unzstd ${src} -o $out 
    '';
}
