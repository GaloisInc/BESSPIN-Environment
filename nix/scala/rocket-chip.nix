{ mkScalaDerivation, sbt, binDeps, chisel3, hardfloat, git
, gfeSrc, rocketChipSrc ? gfeSrc.modules."chisel_processors/rocket-chip"
, version ? "1.2" }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "rocketchip";
  javaPackage = "edu.berkeley.cs";
  inherit version;
  src = rocketChipSrc;

  patches = [ ./rocket-chip-lib-deps.patch ];
  postPatch = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git ];
  scalaDeps = [ binDeps.rocket-chip chisel3 hardfloat ];
}
