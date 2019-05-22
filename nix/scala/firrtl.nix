{ mkScalaDerivation, sbt, protoc-jar, protobuf3_5, git }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "firrtl";
  javaPackage = "edu.berkeley.cs";
  version = "1.2-SNAPSHOT";
  src = builtins.fetchGit {
    url = "https://github.com/freechipsproject/firrtl.git";
    rev = "860e6844708e4b87ced04bcef0eda7810cba106a";
  };

  patchPhase = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git protobuf3_5 ];

  scalaDeps = [ protoc-jar ];
}
