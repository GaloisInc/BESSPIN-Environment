{ mkScalaDerivation, sbt, binDeps, chisel3, hardfloat, git
, rev ? "941a1c161ca1b0bc59b370fb250f2f806e5da0c6" 
, ref ? "ssith-p1"
, suffix ? "p1" }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "rocket-chip-${suffix}";
  javaPackage = "edu.berkeley.cs";
  version = "0.1-SNAPSHOT";
  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/rocket-chip.git";
    inherit rev ref;
  };

  patchPhase = ''
    patch -p1 -i ${./rocket-chip-lib-deps.patch}
    echo 'sbt.version=${sbtVersion}' >project/build.properties
  '';

  buildInputs = [ git ];
  scalaDeps = [ binDeps.rocket-chip chisel3 hardfloat ];
}
