{ stdenv, fetchurl, newScope, lib, gfeSrc
, scala, sbt
, overrides ? (self: super: {})
}:

let
  recursiveScalaDeps = ps:
    ps ++ builtins.concatMap (p: recursiveScalaDeps (p.scalaDeps or [])) ps;

  # Modeled after top-level/python-packages.nix
  packages = self: rec {
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
        overrideScalaAttrs = f: self.mkScalaDerivation (a // f a);

        allScalaDeps = recursiveScalaDeps scalaDeps;
        repoTemplate =
          "[organization]/[module]/[revision]/[type]s/[artifact](-[classifier]).[ext]";
      in stdenv.mkDerivation (a // {
        name = "${javaPackage}-${pname}-${version}";
        inherit version;
        buildInputs = [self.scala self.sbt] ++ buildInputs ++ scalaDeps;


        configurePhase = a.configurePhase or ''
          cat >../sbt.cfg <<EOF
          [repositories]
            local: file://$out/ivy2, ${repoTemplate}
            local-maven: file://${self.genRepo allScalaDeps}/maven
            local-ivy: file://${self.genRepo allScalaDeps}/ivy2, ${repoTemplate}
            preloaded: file://${self.sbt}/share/sbt/lib/local-preloaded, ${repoTemplate}
          EOF
          

          # We have to set user.home directly because Java reads its value from
          # /etc/passwd, not from $HOME
          export SBT_OPTS="
            -Duser.home=$PWD/..
            -Dsbt.override.build.repos=true
            -Dsbt.repository.config=$PWD/../sbt.cfg
          "
        '';

        buildPhase = a.buildPhase or ''
          runHook preBuild
          sbt -v -Dsbt.boot.lock=false -Dsbt.global.base=$PWD/../global-base -Dsbt.boot.directory=$PWD/../boot -Dsbt.ivy.home=$PWD/../ivy ${sbtFlags} compile 
          runHook postBuild
        '';

        installPhase = a.installPhase or ''
          runHook preInstall
          mkdir $out
          sbt ${sbtFlags} publishLocal
          runHook postInstall
        '';

        passthru = {
          inherit overrideScalaAttrs allScalaDeps;
          fullName = "${javaPackage} ${pname} ${version}";
        } // (a.passthru or {});
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

    protoc-jar = callPackage ./protoc-jar.nix {};

    firrtl = callPackage ./firrtl.nix {};
    chisel3 = callPackage ./chisel3.nix {};
    hardfloat = callPackage ./hardfloat.nix {};
    rocket-chip = callPackage ./rocket-chip.nix {};
    chisel-P1 = callPackage ./chisel-processors.nix { procName = "P1"; };
    chisel-P2 = callPackage ./chisel-processors.nix { procName = "P2"; };

    # Boom and P3 are disabled until we have a chance to figure out the new
    # Chisel P3 build process.  See tool-suite#63
    #chisel-P3 = callPackage ./chisel-processors.nix { procName = "P3"; };
    #boom = callPackage ./boom.nix {
    #  rocket-chip = callPackage ./rocket-chip.nix {
    #    rocketChipSrc = gfeSrc.modules."chisel_processors/P3/boom-template/rocket-chip";
    #  };
    #};
    boom = throw "boom package is temporarily unavailable (see tool-suite#63)";

    binDeps = callPackage ./bin-deps.nix {};
  };

in lib.fix' (lib.extends overrides packages)

