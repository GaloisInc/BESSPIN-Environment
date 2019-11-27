{ mkScalaDerivation, binDeps, chisel3
, gfeSrc, hardfloatSrc ?  gfeSrc.modules."chisel_processors/rocket-chip/hardfloat"
, version ? "1.2"
, besspinConfig }:

mkScalaDerivation rec {
  pname = "hardfloat";
  javaPackage = "edu.berkeley.cs";
  inherit version;
  src = besspinConfig.customize.hardfloatSrc or hardfloatSrc;

  patches = [ 
    ./hardfloat-scala-version.patch 
    ./hardfloat-chisel-dep.patch
    ./hardfloat-source-2.11.patch
  ];

  scalaDeps = [ binDeps.chisel3-firrtl-hardfloat chisel3 ];

  sbtFlags = "-Dchisel3Version=${chisel3.version}"; 
}
