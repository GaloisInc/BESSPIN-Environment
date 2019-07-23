# Convert any derivation into a fixed-output derivation with the given SHA256
# hash.  This makes the derivation hashes of downstream packages independent of
# the definition of `pkg`.
#
# The hash to pass for `sha256` can be found by running `nix hash-path --base32
# --type sha256` on the output store path of `pkg`.
{ srcOnly }:
name: sha256: pkg:

let
  outputAttrs = {
    outputHash = sha256;
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };
in
  if pkg ? overrideDerivation then
    pkg.overrideDerivation (old: {
      name = "${old.name}-fixed";
    } // outputAttrs)
  else
    (srcOnly {
      name = "${name}-fixed";
      src = pkg;
    }).overrideDerivation (old: outputAttrs)
