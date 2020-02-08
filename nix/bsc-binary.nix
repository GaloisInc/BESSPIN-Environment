{ stdenv
, makeWrapper
, lib
, fetchurl
, gcc-unwrapped
, gmp4
, besspinConfig
}:

stdenv.mkDerivation rec {
  name = "bsc-${version}";
  version = "2017.07.A";

  src = fetchurl {
    url = "https://s3.wasabisys.com/bluespec/downloads/Bluespec-2017.07.A.tar.gz";
    sha256 = "1b5l8x95kr8fyaigwi9w0f3llzq0930i3gq26j2n6gabjxsmjzz0";
  };

  buildInputs = [ makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/opt/bluespec $out/bin
    cp -r * $out/opt/bluespec

    makeWrapper $out/opt/bluespec/bin/bsc $out/bin/bsc \
      --set BLUESPECDIR $out/opt/bluespec/lib \
      --set BLUESPEC_LICENSE_FILE ${besspinConfig.systemFiles.bluespecLicense}
  '';

  preFixup = let
    libPath = lib.makeLibraryPath [
      gmp4
      gcc-unwrapped.lib
    ];
    in ''
      BINARIES=$out/opt/bluespec/lib/bin/linux64/*
      for binary in $BINARIES
      do
        echo "Patching $binary"
        patchelf \
          --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
          --set-rpath "${libPath}" \
          $binary
      done

      echo "Patching libraries"
      patchelf --set-rpath "${libPath}" $out/opt/bluespec/lib/SAT/g++4_64/libstp.so.1
    '';
}
