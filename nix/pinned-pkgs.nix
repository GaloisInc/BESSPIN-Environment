{ pkgs ? import <nixpkgs> { }
, jsonPath ? ./nixpkgs.json
}:

# https://github.com/Gabriel439/haskell-nix/tree/master/project0
# nix-shell -p nix-prefetch-git --run "nix-prefetch-git https://github.com/nixos/nixpkgs-channels.git refs/heads/nixos-18.09"

let
  nixpkgs = builtins.fromJSON (builtins.readFile jsonPath);

  src = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

in import src { }
