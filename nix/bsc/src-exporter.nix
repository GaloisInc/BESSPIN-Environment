{ callPackage }:

callPackage ./src.nix {
  srcOverrides = {
    "." = {
      rev = "fe9b6111b5b50e00e7fa96ada87f2e3c30842008";
      ref = "ast-export";
    };
  };
}
