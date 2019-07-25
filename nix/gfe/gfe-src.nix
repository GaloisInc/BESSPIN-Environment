
{ stdenv, lib
, srcOverrides ? {}
}:

# Fetch gfe source and all submodules, manually.  Ugly, but it's necessary.
# `pkgs.fetchgit` handles submodules itself, but uses the credentials of the
# Nix build user.  BSC source is in a private repo, so we want to use the
# credentials of the calling user instead.  That means using
# `builtins.fetchGit`, which has no submodule support - we have to fetch each
# one separately.

let
  repo = name: rev: {
    name = "${name}-private";
    url = "git@gitlab-ext.galois.com:ssith/${name}.git";
    inherit rev;
  };

  modulesBase = {
    "." = repo "gfe" "bc6418b9bf2d28c3fdb10526ade2ab37ed3bad9b" // {
      ref = "develop";
    };
    "bluespec-processors/P1/Piccolo" = {
      url = "https://github.com/bluespec/Piccolo/";
      rev = "c47d309f1db1fd0e95020e83803d4649f5d119a1";
    };
    "bluespec-processors/P2/Flute" = {
      url = "https://github.com/bluespec/Flute";
      rev = "4c0f7f67b0c79d25e92417568c9ec818758e78fc";
    };
    "chisel_processors" = repo "chisel_processors" "1a7df30fc26a4f1b9ff8d2fb223b789ae3ea39fb";
  };

  modules = builtins.mapAttrs
    (dest: args:
      if builtins.hasAttr dest srcOverrides then
        args // builtins.getAttr dest srcOverrides
      else
        args)
    modulesBase;

in stdenv.mkDerivation rec {
  name = "gfe-src";
  phases = [ "installPhase" ];
  installPhase =
    lib.concatMapStrings (dest:
      let
        args = builtins.getAttr dest modules;
        src = builtins.fetchGit args;
      in ''
        mkdir -p $out/${dest}
        cp -r ${src}/* $out/${dest}/
        chmod -R u+w $out/${dest}
      '') (builtins.attrNames modules);

  rev = modules.".".rev;
}




