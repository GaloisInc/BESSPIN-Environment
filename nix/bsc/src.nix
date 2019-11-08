{ fetchGit2, assembleSubmodules }:

# Fetch BSC source and all submodules, manually.  Ugly, but it's necessary.
# `pkgs.fetchgit` handles submodules itself, but uses the credentials of the
# Nix build user.  BSC source is in a private repo, so we want to use the
# credentials of the calling user instead.  That means using
# `builtins.fetchGit`, which has no submodule support - we have to fetch each
# one separately.

let
  fetch' = name: rev: args: fetchGit2 ({
    name = "${name}-private";
    url = "git@gitlab-ext.galois.com:bsc_src_access/${name}.git";
    inherit rev;
  } // args);

  fetch = name: rev: fetch' name rev {};

in assembleSubmodules {
  name = "bsc-src-private";
  modules = {
    "." = fetch' "bsc_src" "5a5759d1fafb19ae5555d2692b518e893a0733ba" {
      ref = "ast-export";
    };
    "vendor/Parsec" = fetch "vendor-Parsec" "10bfca04ada994b7a9f9ce35f59d9aefaae5bd94";
    "vendor/boost" = fetch "vendor-boost" "afb26a654938d27ff9c30ac3b79690ed86dee5b5";
    "vendor/cudd" = fetch "vendor-cudd" "4d3a6d967b00fe453b130cf50278ca8aa389447e";
    "vendor/debian" = fetch "vendor-debian" "25edb36b9f7fd4df913285342fea3c7145855969";
    "vendor/eve" = fetch "vendor-eve" "820bd8c3c6e6d272077f3ee744ca5d85ea6ce8f5";
    "vendor/flexlm" = fetch "flexlm-external" "acbea0215a99a5cc3997b67006099ad7deb89b6c";
    "vendor/iverilog" = fetch "vendor-iverilog" "7aaa4c9e730e5c47867af299902e2c4004598871";
    "vendor/libftdi" = fetch' "vendor-libftdi" "6825fc1aa69f29374cba364111f4b1d1c09e5f67" {
      ref = "nix-build";
    };
    "vendor/sha1" = fetch "vendor-sha1" "9adb2057aa432d3a9d48f5ef167c9019c72f5724";
    "vendor/stp" = fetch "vendor-stp" "f1a3c5c15bd8fa876b60dde5d2d5454bc31ace43";
    "vendor/systemc" = fetch "vendor-systemc" "0419bc08aab2aa3da279831cba772561b958f7dd";
    "vendor/tcltk" = fetch "vendor-tcltk" "f2bed9687d83e3957b5197e65627e24ff9f512b5";
    "vendor/usb-driver" = fetch "vendor-usb-driver" "bb22bbffd5b53962ccf2752a4f5f9b916bc5f3c1";
    "vendor/verific" = fetch "vendor-verific" "60cdb9ae5af4484e42d212bb64afd8ed91115ad0";
    "vendor/yices" = fetch "vendor-yices" "087fc53d1804647c17ac0531aa443e0671001c28";
  };
}
