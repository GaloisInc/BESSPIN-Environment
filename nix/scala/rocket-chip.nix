{ mkScalaDerivation, sbt, binDeps, chisel3, hardfloat, git
, rev ? "616ac6391579d60b3cf0a21c15a94ef6ccdd90a9"
, ref ? "ssith-p2-tv"
, suffix ? "" }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "rocket-chip${suffix}";
  javaPackage = "edu.berkeley.cs";
  version = "0.1-SNAPSHOT";
  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/rocket-chip.git";
    inherit rev ref;
  };

  patches = [ ./rocket-chip-lib-deps.patch ];
  postPatch = ''
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git ];
  scalaDeps = [ binDeps.rocket-chip chisel3 hardfloat ];
}
