{ mkScalaDerivation, sbt, binDeps, firrtl, git
, gfeSrc, chisel3Src ? gfeSrc.modules."chisel_processors/rocket-chip/chisel3"
, version ? "3.2-SNAPSHOT"
, besspinConfig }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "chisel3";
  javaPackage = "edu.berkeley.cs";
  inherit version;
  src = besspinConfig.customize.chisel3Src or chisel3Src;

  postPatch = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git ];
  scalaDeps = [ binDeps.chisel3-firrtl-hardfloat firrtl ];
}
