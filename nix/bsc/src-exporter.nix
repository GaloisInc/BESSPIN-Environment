{ callPackage }:

callPackage ./src.nix {
  srcOverrides = {
    "." = {
      rev = "fc8fb0d75a266fbcbbfd91c5027590c456e6d8e5";
      ref = "ast-export";
    };
  };
}
