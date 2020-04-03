{ lib, assembleSubmodules, callPackage, scalaEnv, gfeSrc }:


let
  chisel = proc: config: callPackage ./extracted-arch-chisel.nix {
    chiselProc = proc;
    configTemplate = config;
  };

  bluespec = variant: proc: config: callPackage ./extracted-arch-bluespec.nix {
    bluespecProcSrc = proc;
    inherit variant;
    configTemplate = config;
  };

  chisel-p1 = config: chisel scalaEnv.chisel-P1 config;
  chisel-p2 = config: chisel scalaEnv.chisel-P2 config;
  bluespec-p1 = config: bluespec "P1" gfeSrc.modules."bluespec-processors/P1/Piccolo" config;
  bluespec-p2 = config: bluespec "P2" gfeSrc.modules."bluespec-processors/P2/Flute" config;

# This isn't really the intended purpose of assembleSubmodules, but it works...
in assembleSubmodules {
  name = "extracted-architectures";
  modules = {
    "bluespec/P1/high" = bluespec-p1 ./arch-extract-configs/bluespec-p1.toml;
    "bluespec/P1/low" = bluespec-p1 ./arch-extract-configs/bluespec-p1-low.toml;
    "bluespec/P2/high" = bluespec-p2 ./arch-extract-configs/bluespec-p2.toml;
    "bluespec/P2/low" = bluespec-p2 ./arch-extract-configs/bluespec-p2-low.toml;
    "chisel/P1/high" = chisel-p1 ./arch-extract-configs/chisel-p1-p2.toml;
    "chisel/P1/low" = chisel-p1 ./arch-extract-configs/chisel-p1-p2-low.toml;
    "chisel/P2/high" = chisel-p2 ./arch-extract-configs/chisel-p1-p2.toml;
    "chisel/P2/low" = chisel-p2 ./arch-extract-configs/chisel-p1-p2-low.toml;
    "configs" = builtins.filterSource
      (path: type: lib.hasSuffix ".toml" path)
      ./arch-extract-configs;
  };
}
