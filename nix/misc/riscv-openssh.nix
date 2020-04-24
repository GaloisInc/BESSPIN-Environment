{ stdenv
, riscv-gcc
, openssl_1_0_2
, overrideCC
, fetchFromGitHub
, crossPrefix ? "riscv64-unknown-linux-gnu" }:

let
  stdenvRiscv = overrideCC stdenv riscv-gcc; 

  zlib-riscv = stdenvRiscv.mkDerivation rec {
    pname = "riscv-zlib";
    version = "1.2.11";

    src = fetchFromGitHub {
      owner = "madler";
      repo = "zlib";
      rev = "cacf7f1d4e3d44d871b605da3b647f07d718623f";
      sha256 = "037v8a9cxpd8mn40bjd9q6pxmhznyqpg7biagkrxmkmm91mgm5lg";
    };

    CC="${crossPrefix}-gcc -march=rv64imafdc -mabi=lp64d -fPIC";
    LD="${crossPrefix}-gcc -march=rv64imafdc -mabi=lp64d -fPIC";
    AR="${crossPrefix}-ar";
    RANLIB="${crossPrefix}-ranlib";
  };

  openssl-riscv = (openssl_1_0_2.override{stdenv=stdenvRiscv;}).overrideAttrs (old:  
  rec {
    configureScript = '' ./Configure linux-generic64 --cross-compile-prefix=${crossPrefix}- '';
    configureFlags = [
      "shared" 
      "--openssldir=${placeholder "out"}" 
    ];
    patches = [];
    version="1.0.2";
    outputs = ["out" "bin" "man"];
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

    src = fetchFromGitHub {
      owner = "openssh";
      repo = "openssh-portable";
      rev = "99522ba7ec6963a05c04a156bf20e3ba3605987c";
      sha256 = "06557c7n32wg49py29fyiz8a88508ns809cd8k23i2xj392fy1dd";
    };
  
  };

in openssh-riscv

