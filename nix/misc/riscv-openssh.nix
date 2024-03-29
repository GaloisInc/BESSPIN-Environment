{ clangStdenv
, lib
, riscv-clang
, riscv-llvm
, riscv-lld
, riscv-gcc-linux
, autoconf
, automake
, autoreconfHook
, openssl_1_0_2
, perl
, buildPackages
, overrideCC
, fetchFromGitHub
, riscv-zlib
, sysroot
, crossPrefix ? "riscv64-unknown-linux-gnu" 
, isFreeBSD ? false}:

let
  stdenvRiscv = overrideCC clangStdenv riscv-clang;

  opensslConfig = if isFreeBSD then "BSD-generic64" else "linux-generic64"; 

  ABIFlags = "-march=rv64imafdc -mabi=lp64d -fPIC";  
  ldSelect = if isFreeBSD then " -fuse-ld=${riscv-lld}/bin/ld.lld" else " --gcc-toolchain=${riscv-gcc-linux}";
  CC="clang -target ${crossPrefix} ${ABIFlags} -mno-relax --sysroot=${sysroot} ${ldSelect}";
  LD=CC;
  AR="${riscv-llvm}/bin/llvm-ar";
  RANLIB="${riscv-llvm}/bin/llvm-ranlib";

  openssl-riscv = (openssl_1_0_2.override{stdenv=stdenvRiscv;}).overrideAttrs (old:  
  rec {
    pname = "${crossPrefix}-riscv-openssl";

    version="1.0.2";
    
    outputs = ["out"];
    
    # no official target exists for riscv..., so use generic
    configureScript = '' ./Configure ${opensslConfig} '';

    # no need for shared build
    configureFlags = [
      "--openssldir=${placeholder "out"}" 
      "disable-ssl2"
      "disable-ssl3"
      "no-shared"
    ];

    enableParallelBuilding = false;

    # no need to set man vars
    makeFlags = [];

    # cannot use for host architecture 
    buildInputs = [];

    # don't patch for CVEs
    patches = [];

    separateDebugInfo = false;

    # see https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/libraries/openssl/default.nix
    postInstall = ''
      substituteInPlace $out/bin/c_rehash --replace ${buildPackages.perl} ${perl}
    '';

    dontFixup = true;

    # the desired version source
    src = fetchFromGitHub {
      owner = "openssl";
      repo = "openssl";
      rev = "4ac0329582829f5378d8078c8d314ad37db87736";
      sha256 = "1wcpq5llkikxff8bp9f0s2isa4ysj0ry68mkvj05k1z9rszym3dj";
    };

    inherit CC LD AR RANLIB;
  });

  openssh-riscv = stdenvRiscv.mkDerivation {
    pname = "${crossPrefix}-openssh";
    version = "7.3";
    buildInputs = [
      riscv-zlib
      openssl-riscv
    ];

    configureFlags = [
      "--prefix="
      "--with-privsep-path=/var/empty"
      "--exec-prefix=" 
      "--sysconfdir=/etc/ssh"
      "--host=${crossPrefix}"
      "--with-libs"
      "--with-zlib=${riscv-zlib}"
      "--with-ssl-dir=${openssl-riscv}"
      "--with-pid-dir=/etc"
      "--disable-etc-default-login"
    ];

    nativeBuildInputs = [autoconf automake autoreconfHook riscv-llvm];

    # permissions issue when installing -- use only 755    
    postConfigure = ''
      sed 's/$(INSTALL) -m 4711/$(INSTALL) -m 0755/g' -i Makefile
      sed 's/#define _PATH_SSH_PIDDIR .*/#define _PATH_SSH_PIDDIR \"\/etc\"/' -i config.h 
      sed 's/prefix=.*/prefix=\//' -i opensshd.init
      sed 's/piddir=.*/piddir=\//' -i opensshd.init
    '' + lib.optionalString isFreeBSD 
    ''
      sed 's/#define USE_BTMP .*/\/\* #define USE_BTMP 1 \*\//' -i config.h
    '';

    dontFixup = true;

    #installPhase = ''make STRIP_OPT="--strip-program=${crossPrefix}-strip -s" install-files'';
    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/sbin
      mkdir -p $out/libexec
      mkdir -p $out/var/empty
      mkdir -p $out/config

      install -c -m 0755 --strip-program=llvm-strip -s ssh $out/bin/ssh
      install -c -m 0755 --strip-program=llvm-strip -s scp $out/bin/scp
      install -c -m 0755 --strip-program=llvm-strip -s ssh-add $out/bin/ssh-add
      install -c -m 0755 --strip-program=llvm-strip -s ssh-keygen $out/bin/ssh-keygen
      install -c -m 0755 --strip-program=llvm-strip -s ssh-keyscan $out/bin/ssh-keyscan
      install -c -m 0755 --strip-program=llvm-strip -s sftp $out/bin/sftp
      install -c -m 0755 --strip-program=llvm-strip -s sftp-server $out/libexec/sftp-server
      install -c -m 0755 --strip-program=llvm-strip -s ssh-keysign $out/libexec/ssh-keysign
      install -c -m 0755 --strip-program=llvm-strip -s ssh-pkcs11-helper $out/libexec/ssh-pkcs11-helper

      install -c -m 0755 --strip-program=llvm-strip -s sshd $out/sbin/sshd

      cp ssh_config $out/config
      cp sshd_config $out/config
    '';

    src = fetchFromGitHub {
      owner = "openssh";
      repo = "openssh-portable";
      rev = "99522ba7ec6963a05c04a156bf20e3ba3605987c";
      sha256 = "06557c7n32wg49py29fyiz8a88508ns809cd8k23i2xj392fy1dd";
    };
  
    inherit CC LD AR RANLIB;
  };

in openssh-riscv

