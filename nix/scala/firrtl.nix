{ mkScalaDerivation, sbt, binDeps, protoc-jar, protobuf3_5, git
, gfeSrc, firrtlSrc ? gfeSrc.modules."chisel_processors/rocket-chip/firrtl"
, version ? "1.2-SNAPSHOT"
, besspinConfig }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "firrtl";
  javaPackage = "edu.berkeley.cs";
  inherit version;
  src = besspinConfig.customize.firrtlSrc or firrtlSrc;

  postPatch = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git protobuf3_5 ];

  scalaDeps = [ binDeps.chisel3-firrtl-hardfloat protoc-jar ];
}
