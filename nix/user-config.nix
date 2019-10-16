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

    # Options for replacing certain tool suite components with custom versions,
    # which will be used in place of the originals for downstream build steps.
    # For example, if you set `customize.gnuToolchainSrc` to the path to a
    # customized version of `riscv-gnu-toolchain`, the tool suite will compile
    # GCC from those sources and use it when building Linux kernel images or
    # test binaries.
    customize = {

      # Replace the GFE simulator binaries with custom versions.  For each
      # "name = path" pair, the tool suite will copy the binary from `path` and
      # give it the standard name `gfe-simulator-${name}`.
      #
      # When `simulatorBins` is set, all default GFE simulators will be omitted
      # from the build.  However, it is legal to omit some keys from the map -
      # for example, if you have only Chisel simulators, you can omit the
      # `bluespec_*` keys.  In that case, the `gfe-simulator-bluespec_*`
      # binaries will not be available in the nix shell.
      #simulatorBins = {
      #  chisel_p1 = /path/to/exe_HW_chisel_p1_sim;
      #  chisel_p2 = /path/to/exe_HW_chisel_p2_sim;
      #  bluespec_p1 = /path/to/exe_HW_bluespec_p1_sim;
      #  bluespec_p2 = /path/to/exe_HW_bluespec_p2_sim;
      #  elf_to_hex = /path/to/elf_to_hex;
      #};

      # Obtain processor bitstreams from a custom directory, instead of from
      # `gfe/bitstreams/`.  The bitstreams directory should have the same
      # layout as in the GFE, with a pair of files `soc_${proc}.bit` and
      # `soc_${proc}.ltx` for each processor.  The tool-suite command
      # `gfe-program-fpga ${proc}` will then program the FPGA using the files
      # copied from this custom directory.
      #
      # As with `simulatorBins`, it's legal to omit some files from this
      # directory.  For example, if you only plan to test Bluespec P1
      # processors, your `bitstreams` directory only needs to contain
      # `soc_bluespec_p1.bit` and `soc_bluespec_p1.ltx`.
      #bitstreams = /path/to/bitstreams;

      # Replace the sources for riscv-gnu-toolchain with a custom version.  The
      # entire toolchain (all the `riscv64-unknown-elf-*` and
      # `riscv64-unknown-linux-gnu-*` binaries) will be built from the custom
      # sources.
      #gnuToolchainSrc = /path/to/riscv-gnu-toolchain;

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

