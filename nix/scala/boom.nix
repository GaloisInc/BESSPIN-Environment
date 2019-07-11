{ mkScalaDerivation, sbt, binDeps, chisel3, hardfloat, rocket-chip, git
, rev ? "539c22a878fe509fb8bd1370e737007b27bc3a28"
, ref ? "ssith-2.2.1"
, suffix ? "" }:

let
  sbtVersion = (builtins.parseDrvName sbt.name).version;
in mkScalaDerivation rec {
  pname = "boom${suffix}";
  javaPackage = "edu.berkeley.cs";
  version = "1.0";
  src = builtins.fetchGit {
    url = "git@gitlab-ext.galois.com:ssith/riscv-boom.git";
    inherit rev ref;
  };

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
