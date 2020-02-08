{stdenv, fetchFromGitHub, pkgconfig, cheri-clang}:

stdenv.mkDerivation rec {
    name = "cheri-newlib";
    src = fetchFromGitHub {
        owner = "CTSRD-CHERI";
        repo = "newlib";
        rev = "94e32932f9382ab583d3385483ce60997e1195c1";
        sha256 = "0s1kl1kgl8h03hrd3g0617mawl8kc7hci351jfh1wmy75fs2jxy8";
    };
    nativeBuildInputs = [ pkgconfig ];
    depsBuildBuild = [ cheri-clang ];
    preConfigure = ''
        mkdir -p /build/tmp/lib
        cp -r newlib/libc/include /build/tmp
        cd newlib/libc/
        export ${builtins.concatStringsSep " " configureEnv}
    '';
    configureFlags = [
        ''--build=riscv32-unknown-elf''
        ''--disable-newlib-io-float''
    ];
    configureEnv = [
        ''CC=riscv32-unknown-elf-clang'' 
        ''CFLAGS="-march=rv32imxcheri -mabi=il32pc64 -ffreestanding -Werror -I$PWD/include --sysroot=$SPAREFS/gfe/sysroot32"''
        ''LD=riscv32-unknown-elf-ld'' 
        ''LDFLAGS="-fuse-ld=lld -mno-relax" ''
        ''RANLIB=llvm-ranlib''
        ''AR=llvm-ar ''
    ];
    postBuild = ''
        mv libc.a /build/tmp/lib
    '';
    installPhase = 
    ''
    mv /build/tmp $out
    '';
}