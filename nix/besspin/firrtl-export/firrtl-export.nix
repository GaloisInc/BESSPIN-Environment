{ stdenv, fetchGit2, scalaEnv }:

stdenv.mkDerivation rec {
  name = "firrtl-export";
  version = "0.1.0-SNAPSHOT";

  src = "./";

  buildInputs = [
    (scalaEnv.withPackages (ps: with ps; [
      firrtl
      binDeps.chisel3-firrtl-hardfloat
      binDeps.sbt-pack
      binDeps.borer
    ]))
  ];

  buildPhase = ''
    sbt -Dsbt.boot.lock=false -Dsbt.global.base=$PWD/../global-base -Dsbt.boot.directory=$PWD/../boot -Dsbt.ivy.home=$PWD/../ivy -Dsbt.override.build.repos=true assembly
  '';

  installPhase = ''
    mkdir -p $out/share/firrtl-export
    cp target/scala-2.12/firrtl-export-assembly-${version}.jar \
      $out/share/firrtl-export/firrtl-export.jar
  '';
}
