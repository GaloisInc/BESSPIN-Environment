{ stdenv
, riscv-gcc
, autoconf
, automake
, autoreconfHook
, openssl_1_0_2
, perl
, buildPackages
, overrideCC
, fetchFromGitHub
, crossPrefix ? "riscv64-unknown-linux-gnu" 
, isFreeBSD ? false}:

let
  stdenvRiscv = overrideCC stdenv riscv-gcc;

  opensslConfig = if isFreeBSD then "BSD-generic64" else "linux-generic64"; 

  ABIFlags = "-march=rv64imafdc -mabi=lp64d -fPIC";  
  CC="${crossPrefix}-gcc ${ABIFlags}";
  LD="${crossPrefix}-gcc ${ABIFlags}";
  AR="${crossPrefix}-ar";
  RANLIB="${crossPrefix}-ranlib";

  zlib-riscv = stdenvRiscv.mkDerivation rec {
    pname = "riscv-zlib";
    version = "1.2.11";

    src = fetchFromGitHub {
      owner = "madler";
      repo = "zlib";
      rev = "cacf7f1d4e3d44d871b605da3b647f07d718623f";
      sha256 = "037v8a9cxpd8mn40bjd9q6pxmhznyqpg7biagkrxmkmm91mgm5lg";
    };
    
    inherit CC LD AR RANLIB;
  };

  openssl-riscv = (openssl_1_0_2.override{stdenv=stdenvRiscv;}).overrideAttrs (old:  
  rec {
    version="1.0.2";
    
    outputs = ["out"];
    
    # no official target exists for riscv..., so use generic
    configureScript = '' ./Configure ${opensslConfig} --cross-compile-prefix=${crossPrefix}- '';

    # no need for shared build
    configureFlags = [
      "--openssldir=${placeholder "out"}" 
      "disable-ssl2"
      "disable-ssl3"
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

    postFixup = "";

    # the desired version source
    src = fetchFromGitHub {
      owner = "openssl";
      repo = "openssl";
      rev = "4ac0329582829f5378d8078c8d314ad37db87736";
      sha256 = "1wcpq5llkikxff8bp9f0s2isa4ysj0ry68mkvj05k1z9rszym3dj";
    };

    CC="gcc -march=rv64imafdc -mabi=lp64d -fPIC";
    LD="gcc -march=rv64imafdc -mabi=lp64d -fPIC";
    AR="ar r";
    RANLIB="ranlib";
  });

  openssh-riscv = stdenvRiscv.mkDerivation {
    pname = "openssh";
    version = "7.3";
    buildInputs = [
      zlib-riscv
      openssl-riscv
    ];

    configureFlags = [
      "--prefix=${placeholder "out"}"
      "--with-privsep-path=${placeholder "out"}/var/empty"
      "--host=${crossPrefix}"
      "--with-libs"
      "--with-zlib=${zlib-riscv}"
      "--with-ssl-dir=${openssl-riscv}"
      "--disable-etc-default-login"
    ];

    nativeBuildInputs = [autoconf automake autoreconfHook];

    # permissions issue when installing -- use only 755    
    postConfigure = ''
      sed 's/$(INSTALL) -m 4711/$(INSTALL) -m 0755/g' -i Makefile
    '' + stdenv.lib.optionalString isFreeBSD 
    ''
      sed 's/#define USE_BTMP .*/\/\* #define USE_BTMP 1 \*\//' -i config.h
    '';

    installPhase = ''make STRIP_OPT="--strip-program=${crossPrefix}-strip -s" install-files'';

    src = fetchFromGitHub {
      owner = "openssh";
      repo = "openssh-portable";
      rev = "99522ba7ec6963a05c04a156bf20e3ba3605987c";
      sha256 = "06557c7n32wg49py29fyiz8a88508ns809cd8k23i2xj392fy1dd";
    };
  
    inherit CC LD AR RANLIB;
  };

in openssh-riscv

