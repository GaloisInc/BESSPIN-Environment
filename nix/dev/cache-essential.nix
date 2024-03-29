# This shell provides a list of packages that should be published to the binary
# cache every time they change, even between releases.  This is a mix of
# packages that involve large downloads, are slow to build, or have private
# sources.

{}:

let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage lib;
  besspin = callPackage ../besspin-pkgs.nix {};

in mkShell {
  cachePackages = with besspin; [
    # Slow builds
    riscv-gcc
    riscv-gcc-linux

    # Large downloads
    gfeSrc.modules."."
    gfeSrc.modules.riscv-linux
    gfeSrc.modules.busybox
    debianRepoSnapshot
  ];

  LANG = "en_US.UTF-8";
}
