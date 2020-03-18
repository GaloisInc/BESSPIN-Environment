{ stdenv
, freebsdWorld
}:

stdenv.mkDerivation rec {
  name = "freebsd-sysroot";

  src = freebsdWorld;

  dontConfigure = true;
  dontFixup = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/usr
    cp -r usr/lib usr/include $out/usr
    cp -r lib $out
  '';
}
