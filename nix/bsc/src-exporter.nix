{ callPackage }:

callPackage ./src.nix {
  srcOverrides = {
    "." = {
      rev = "2b15a1f5af84dbbfd03a63b5ad48c452e4babfae";
      ref = "ast-export";
    };
  };
}
