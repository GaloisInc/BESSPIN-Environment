{ mkScalaDerivation
, chisel3
}:

mkScalaDerivation rec {
  pname = "hardfloat";
  javaPackage = "edu.berkeley.cs";
  version = "1.2";
  src = builtins.fetchGit {
    url = "https://github.com/ucb-bar/berkeley-hardfloat.git";
    rev = "45f5ae171a1950389f1b239b46a9e0d16ae0a6f4";
  };

  patches = [ 
    ./hardfloat-scala-version.patch 
    ./hardfloat-chisel-dep.patch
    ./hardfloat-source-2.11.patch
  ];

  scalaDeps = [ chisel3 ];

  sbtFlags = "-Dchisel3Version=${chisel3.version}"; 
}
