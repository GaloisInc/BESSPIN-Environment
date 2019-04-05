{ stdenv
, newScope
, lib
, racket
, overrides ? (self: super: {})
}:

let
  recursiveRacketDeps = ps:
    ps ++ builtins.concatMap (p: recursiveRacketDeps (p.racketDeps or [])) ps;

  # Modeled after top-level/python-packages.nix
  packages = self: {
    callPackage = newScope self;
    inherit racket;

    genRacketConfig = pkgs:
      let files = lib.concatStringsSep " " pkgs;
      in "${self.racket}/bin/racket ${./gen-racket-config.rkt} ${files} " +
        "<${self.racket}/etc/racket/config.rktd";

    withPackages = f: stdenv.mkDerivation rec {
      name = "racket-with-packages";
      phases = ["installPhase"];

      buildInputs = [ self.racket ];

      installPhase = ''
        mkdir -p $out/bin $out/etc/racket

        ${self.genRacketConfig (recursiveRacketDeps (f self))} >$out/etc/racket/config.rktd

        echo '#!/bin/sh' >$out/bin/racket
        echo "exec ${self.racket}/bin/racket -G $out/etc/racket \"\$@\"" >>$out/bin/racket
        chmod +x $out/bin/racket
      '';
    };

    mkRacketDerivation = a@
      { pname
      , version
      , buildInputs ? []
      , racketDeps ? []
      , subdir ? "."
      , ... }: stdenv.mkDerivation (a // {
        name = "${pname}-${version}";
        buildInputs = [self.racket] ++ buildInputs ++ racketDeps;

        phases = ["unpackPhase" "patchPhase" "setupPhase" "installPhase"];

        setupPhase = ''
          mkdir ../racket-config
          ${self.genRacketConfig (racketDeps ++ ["$out"])} >../racket-config/config.rktd
        '';

        installPhase = ''
          export HOME=$PWD/..
          export PLTCONFIGDIR=$PWD/../racket-config
          cd '${subdir}'
          raco pkg install \
            --no-setup --deps force \
            --scope-dir $out --copy -t dir -n ${pname} $PWD
          raco setup --no-user --no-pkg-deps --only --pkgs ${pname}
        '';
      });

    rfc6455 = self.callPackage ./rfc6455.nix {};
    rosette = self.callPackage ./rosette.nix {};
    parsack = self.callPackage ./parsack.nix {};
    toml = self.callPackage ./toml.nix {};
  };

in lib.fix' (lib.extends overrides packages)

