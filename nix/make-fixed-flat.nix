# A version of makeFixed for single file store paths
{}:
name: sha256: pkg:
pkg.overrideAttrs (old: {
  name = name + "-fixed";
  outputHash = sha256;
  outputHashAlgo = "sha256";
  outputHashMode = "flat";
})
