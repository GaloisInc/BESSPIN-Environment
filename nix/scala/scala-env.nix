{ stdenv, fetchurl
, newScope
, lib
, scala, sbt
, strace
, overrides ? (self: super: {})
}:

let
  recursiveScalaDeps = ps:
    ps ++ builtins.concatMap (p: recursiveScalaDeps (p.scalaDeps or [])) ps;

  # Modeled after top-level/python-packages.nix
  packages = self: {
    callPackage = newScope self;
    inherit scala;

    inherit sbt;

    genRepo = pkgs: stdenv.mkDerivation {
      name = "scala-repo";
      phases = [ "installPhase" ];
      installPhase = ''
        echo "building repo..."
        mkdir $out
        ${lib.concatMapStringsSep "\n"
          (pkg: "cp -r --no-preserve=mode ${pkg}/* $out/")
          pkgs}
      '';
    };

    genRepoConfig = pkgs: let
      template = "[organization]/[module]/[revision]/[type]s/[artifact](-[classifier]).[ext]";
    in stdenv.mkDerivation {
      name = "scala-repo-config";
      phases = [ "installPhase" ];
      installPhase = ''
      '';
    };

    withPackages = f: let
      pkgs = f self;
      repoTemplate =
        "[organization]/[module]/[revision]/[type]s/[artifact](-[classifier]).[ext]";
    in stdenv.mkDerivation rec {
      name = "sbt-with-packages";
      phases = ["installPhase"];

      buildInputs = [ ];

      installPhase = ''
        mkdir -p $out/bin $out/etc/sbt

        cat >$out/etc/sbt/repositories <<EOF
        [repositories]
          local-maven: file://${self.genRepo pkgs}/maven
          local-ivy: file://${self.genRepo pkgs}/ivy2, ${repoTemplate}
          preloaded: file://${self.sbt}/share/sbt/lib/local-preloaded, ${repoTemplate}
        EOF

        echo '#!/bin/sh' >$out/bin/sbt
        echo "exec ${self.sbt}/bin/sbt \\" >>$out/bin/sbt
        echo "  -Dsbt.repository.config=$out/etc/sbt/repositories \"\$@\"" >>$out/bin/sbt
        chmod +x $out/bin/sbt
      '';
    };

    mkScalaDerivation = a@
      { pname
      , javaPackage
      , version
      , buildInputs ? []
      , scalaDeps ? []
      , sbtFlags ? ""
      , ... }:
      let
        allScalaDeps = recursiveScalaDeps scalaDeps;
        repoTemplate =
          "[organization]/[module]/[revision]/[type]s/[artifact](-[classifier]).[ext]";
      in stdenv.mkDerivation (a // {
        name = "${javaPackage}-${pname}-${version}";
        inherit version;
        buildInputs = [self.scala self.sbt] ++ buildInputs ++ scalaDeps;

        phases = a.phases or [
          "unpackPhase" "patchPhase" "setupPhase" "buildPhase" "installPhase"
        ];

        setupPhase = a.setupPhase or ''
          cat >../sbt.cfg <<EOF
          [repositories]
            local: file://$out/ivy2, ${repoTemplate}
            local-maven: file://${self.genRepo allScalaDeps}/maven
            local-ivy: file://${self.genRepo allScalaDeps}/ivy2, ${repoTemplate}
            preloaded: file://${self.sbt}/share/sbt/lib/local-preloaded, ${repoTemplate}
          EOF

          export SBT_OPTS="
            -Dsbt.ivy.home=$PWD/../.ivy2
            -Dsbt.boot.directory=$PWD/../.sbt/boot
            -Dsbt.global.base=$PWD/../.sbt
            -Dsbt.global.staging=$PWD/../.staging
            -Dsbt.override.build.repos=true
            -Dsbt.repository.config=$PWD/../sbt.cfg
          "
        '';

        buildPhase = a.buildPhase or ''
          sbt -v ${sbtFlags} compile
        '';

        installPhase = a.installPhase or ''
          mkdir $out
          sbt ${sbtFlags} publishLocal
        '';
      });

    mkBinPackage =
      { name, pname, version, org
      , jarUrl, jarSha256, jarDest
      , metaUrl, metaSha256, metaDest
      }: stdenv.mkDerivation {
        name = "${name}-${version}";
        src = fetchurl {
          url = jarUrl;
          sha256 = jarSha256;
        };
        metaSrc = fetchurl {
          url = metaUrl;
          sha256 = metaSha256;
        };

        phases = ["installPhase"];
        installPhase = ''
          install -D $src $out/${jarDest}
          install -D $metaSrc $out/${metaDest}
        '';
      };

    mkMetadataPackage =
      { name, pname, version, org
      , metaUrl, metaSha256, metaDest
      }: stdenv.mkDerivation {
        name = "${name}-${version}";
        src = fetchurl {
          url = metaUrl;
          sha256 = metaSha256;
        };

        phases = ["installPhase"];
        installPhase = ''
          install -D $src $out/${metaDest}
        '';
      };

    protoc-jar = self.callPackage ./protoc-jar.nix {};

    firrtl = self.callPackage ./firrtl.nix {};
    chisel3 = self.callPackage ./chisel3.nix {};
    hardfloat = self.callPackage ./hardfloat.nix {};
    rocket-chip = self.callPackage ./rocket-chip.nix {};

    binDeps = self.callPackage ./bin-deps.nix {};
  };

in lib.fix' (lib.extends overrides packages)

