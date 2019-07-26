{ aeSrc, mkScalaDerivation, sbt, binDeps }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "rocket-chip-config-plugin";
  javaPackage = "com.galois.besspin";
  version = "0.1.0-SNAPSHOT";
  src = aeSrc;

  postUnpack = ''
    mv source source-root
    mv source-root/rocket-chip-config-plugin source
  '';

  postPatch = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ ];
  scalaDeps = [ binDeps.chisel3-firrtl-hardfloat ];
}
