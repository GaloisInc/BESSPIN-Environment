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

  # Build the jar file for FIRRTL CLI utility
  postBuild = ''
  sbt -v -Dsbt.boot.lock=false -Dsbt.global.base=$PWD/../global-base -Dsbt.boot.directory=$PWD/../boot -Dsbt.ivy.home=$PWD/../ivy assembly
  '';

  postInstall = ''
    cp -R utils/bin $out
  '';

  buildInputs = [ git protobuf3_5 ];

  scalaDeps = [ binDeps.chisel3-firrtl-hardfloat protoc-jar ];
}
