{ stdenv, callPackage
, haskell
, perl, zlib, libusb, bison, flex, boost, fontconfig, tcl, xorg
}:

let
  bscSrc = callPackage ./src.nix {};

  haskellEnv = haskell.packages.ghc822.override {
    overrides = self: super: {
      aeson = haskell.lib.overrideCabal super.aeson (old: {
        libraryHaskellDepends = old.libraryHaskellDepends ++ [self.contravariant];
        testHaskellDepends = old.testHaskellDepends ++ [self.contravariant];
      });
    };
  };

in stdenv.mkDerivation rec {
  name = "bsc-${builtins.substring 0 7 src.rev}";
  src = bscSrc;

  buildInputs = [
    perl zlib libusb bison flex boost fontconfig tcl
    (xorg.libX11) (xorg.libXft)
    (haskellEnv.ghcWithPackages (ps: with ps; [
      syb regex-compat old-time cborg
    ]))
  ];

  postPatch = ''
    patchShebangs .
  '';

  configurePhase = ''
    export BOOST_HOME=${boost}
    export BSC_LIC_POLICY=DATE_REVERT
    export EXP_TIME_IN_SECS=$(date -d "December 31, 2021 23:59" +%s)
  '';

  buildPhase = ''
    make -C vendor
    make -C src/comp install-bsc
    make -C util/scripts install
    make -C src/lib/Prelude build
    make -C src/lib/Libraries build NOAZURE=1

    # Remaining lines must respect BUILD_ORDER in BSVSource/Makefile
    make -C src/lib/BSVSource/Misc build
    make -C src/lib/BSVSource/Contexts build
    make -C src/lib/BSVSource/Math build
  '';

  installPhase = ''
    mkdir $out
    cp -r inst/* $out

    mkdir -p $out/lib
    cp -r build/bsvlib/Prelude $out/lib/
  '';
}
