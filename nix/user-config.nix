{}:

with builtins;
let

  # This is the default configuration for the tool-suite packages.  
  defaultConfig = {

    # Whether to build private packages from source.  Note that most TA-1 teams
    # do not have access to the source repositories, and thus will not be able
    # to build these packages.
    buildPrivate = {
      verific = false;
      bsc = false;
    };

    # Whether to fetch large source packages directly, rather than using the
    # cached copies.  Most of these are git repositories, where a clone (with
    # full history) is much larger than the snapshot that would be downloaded
    # from the cache.
    fetchUncached = {
      riscv-linux = false;
      busybox = false;
      gfe = false;
      debian-repo-snapshot = false;
    };

  };


  xdgConfigDir = getEnv "XDG_CONFIG_HOME";
  homeConfigDir = "${getEnv "HOME"}/.config";
  configDir = if xdgConfigDir != "" then xdgConfigDir else homeConfigDir;
  configFile = "${configDir}/besspin/config.nix";

  fileConfig = if pathExists configFile then import configFile else {};


  configLayers = [ defaultConfig fileConfig ];

  # `mergedConfig` contains the final values for fields where later values
  # should be merged with earlier ones, instead of overriding them.
  mergedConfig = {
    haveSrc = foldl' (old: new: old // new) {} (catAttrs "haveSrc" configLayers);
    fetchUncached = foldl' (old: new: old // new) {} (catAttrs "fetchUncached" configLayers);
  };

in defaultConfig // fileConfig // mergedConfig

