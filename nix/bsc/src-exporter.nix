{ callPackage }:

callPackage ./src.nix {
  srcOverrides = {
    "." = {
      rev = "b777e1e31bf094b48919455c36a3ca8c8de460d0";
      ref = "ast-export";
    };
  };
}
