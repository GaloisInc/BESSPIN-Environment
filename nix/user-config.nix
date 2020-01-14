{ callPackage }:

with builtins;
let
  defaultConfig = import ./default-user-config.nix;


  xdgConfigDir = getEnv "XDG_CONFIG_HOME";
  homeConfigDir = "${getEnv "HOME"}/.config";
  configDir = if xdgConfigDir != "" then xdgConfigDir else homeConfigDir;
  configFile = "${configDir}/besspin/config.nix";

  fileConfig =
    if !(pathExists configFile) then {}
    else let
      x = import configFile;
    in if builtins.typeOf x == "lambda" then callPackage x {} else x;


  configLayers = [ defaultConfig fileConfig ];

  # `mergedConfig` contains the final values for fields where later values
  # should be merged with earlier ones, instead of overriding them.
  mergedConfig = {
    haveSrc = foldl' (old: new: old // new) {} (catAttrs "haveSrc" configLayers);
    fetchUncached = foldl' (old: new: old // new) {} (catAttrs "fetchUncached" configLayers);
  };

in defaultConfig // fileConfig // mergedConfig
