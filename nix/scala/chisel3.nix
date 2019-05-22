{ mkScalaDerivation, sbt, firrtl, git }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "chisel3";
  javaPackage = "edu.berkeley.cs";
  version = "3.2-SNAPSHOT";
  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/chisel3.git";
    rev = "d17be75d919d65d9831d085bd4b5ea72e53156a6";
    ref = "ssith-tv";
  };

  patchPhase = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git ];
  scalaDeps = [ firrtl ];
}
