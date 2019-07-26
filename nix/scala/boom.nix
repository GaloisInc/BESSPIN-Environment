{ mkScalaDerivation, sbt, binDeps, chisel3, hardfloat, rocket-chip, git
, gfeSrc, boomSrc ? gfeSrc.modules."chisel_processors/P3/boom-template/boom"
, version ? "1.0" }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "boom";
  javaPackage = "edu.berkeley.cs";
  inherit version;
  src = boomSrc;

  patches = [ ./boom-lib-deps.patch ];
  postPatch = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git ];
  scalaDeps = [ binDeps.rocket-chip chisel3 hardfloat rocket-chip ];

  passthru = {
    inherit rocket-chip;
  };
}
