{ stdenv, fetchGit2, scalaEnv }:

stdenv.mkDerivation rec {
  name = "firrtl-export";
  version = "0.1.0-SNAPSHOT";

  src = fetchGit2 {
    url = "git@gitlab-ext.galois.com:ssith/firrtl-export.git";
    rev = "25f7f641e0db1f8bd184fd91ee0d66377d598b4f";
  };

  buildInputs = [
    (scalaEnv.withPackages (ps: with ps; [
      firrtl
      binDeps.chisel3-firrtl-hardfloat
      binDeps.sbt-pack
      binDeps.borer
    ]))
  ];

  buildPhase = ''
    sbt -Dsbt.override.build.repos=true assembly
  '';

  installPhase = ''
    mkdir -p $out/share/firrtl-export
    cp target/scala-2.12/firrtl-export-assembly-${version}.jar \
      $out/share/firrtl-export/firrtl-export.jar
  '';
}
