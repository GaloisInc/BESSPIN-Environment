pkgs@{ newScope, lib
, bash, coreutils, gawk, go, python37, haskell, rWrapper, rPackages
, racket, scala, sbt, texlive, jre, writeShellScriptBin, fetchurl, symlinkJoin
, overrides ? (self: super: {})
}:

let
  packages = self: rec {
    # Normal `callPackage`, providing all nixpkgs + BESSPIN packages
    callPackage = pkgs.newScope self;
    # Also extend `newScope`, so that `scala-env.nix` and other sub-scopes will
    # be able to see BESSPIN-specific packages.  (Without this, we'd inherit
    # the `nixpkgs` `newScope`, which only includes base packages in the new
    # scope.)
    newScope = extra: pkgs.newScope (self // extra);

    besspinConfig = callPackage ./user-config.nix {};
    config = besspinConfig;

    # A newer version of `nixpkgs`, used to get Clang 9.0 (with RISC-V support)
    # TODO: bump the main nixpkgs revision, and remove this
    pkgsForRiscvClang = import ./pinned-pkgs.nix {
      jsonPath = ./nixpkgs-for-riscv-clang.json;
    };

    binWrapperNamed = callPackage ./bin-wrapper.nix {};
    binWrapper = path: binWrapperNamed (baseNameOf path) path;
    makeTarFile = callPackage ./tar-file.nix {};
    unpacker = callPackage ./unpacker.nix {};
    unpackerGfe = callPackage ./unpacker.nix { prefix = "gfe"; };
    makeFixed = callPackage ./make-fixed.nix {};
    makeFixedFlat = callPackage ./make-fixed-flat.nix {};
    assembleSubmodules = callPackage ./assemble-submodules.nix {};

    inherit (callPackage ./overridable-fetchgit.nix {}) fetchGit2 fetchFromGitHub2;

    dummyPackagePrivate = name: callPackage ./dummy-package.nix {
      inherit name;
      message = ''
        error: source code for package `${name}` is not available

        Please set up the BESSPIN Nix binary cache if possible (please contact Galois).

        You can also use `nix-shell --arg skipPrivate true` to bypass this
        requirement, but some functionality will be limited.
      '';
    };

    dummyPackagePerf = name: rev: callPackage ./dummy-package.nix {
      inherit name rev;
      message = ''
        error: uncached fetches of `${name}` sources are disabled for performance reasons

        Sources for this package should normally be fetched from the BESSPIN
        Nix binary cache (please contact Galois).

        To bypass this warning and fetch the sources directly, set
        `fetchUncached.${name}` to `true` in `~/.config/besspin/config.nix`.
      '';
    };
    togglePackagePerf = name: sha256: real: rev:
      let extName = "${name}-src";
      in makeFixed extName sha256
        (if config.fetchUncached."${name}" or false then real
          else dummyPackagePerf name rev);

    # "Major" dependencies.  These are language interpreters/compilers along with
    # sets of libraries.
    #
    # In general, we try to use the same env across all packages and wrapper
    # scripts.  This way, when the user runs `python3` (for example) inside the
    # nix-shell, the packages they see are the same ones that are available
    # within the various wrapper scripts.

    python3Env = pkgs.python37.override {
      packageOverrides = self: super: {
        cbor2 = self.callPackage python/cbor2.nix {};
        tftpy = self.callPackage python/tftpy.nix {};
        zstandard = self.callPackage python/zstandard.nix {};
      };
    };
    python3 = python3Env.withPackages (ps: with ps; [
      # Used by the configurator
      flask flask-restplus
      # Used by bofgen test harness
      matplotlib
      # Useful for arch-extract testing/debugging
      cbor2
      # Used by Nix binary cache deployment scripts
      requests
      # Dependencies of gfe's run_elf.py
      pyserial pexpect configparser
      # For testgen
      scapy tftpy 
    ]);

    haskellEnv = pkgs.haskell.packages.ghc844.override {
      overrides = self: super: {
        # Inject custom fetch functions into the Haskell package set, which
        # does not inherit from the BESSPIN package set.
        inherit fetchGit2 fetchFromGitHub2;

        # Clafer dependencies.  The default versions from nixpkgs don't build
        # successfully on this GHC version.
        data-stringmap = self.callPackage haskell/data-stringmap-1.0.1.1.nix {};
        json-builder = self.callPackage haskell/json-builder-0.3-for-ghc84.nix {};
        clafer_0_4_5 = self.callPackage haskell/clafer-0.4.5.nix {};
        clafer_0_5_0 = self.callPackage haskell/clafer-0.5.0.nix {};
        clafer_0_5_besspin = self.callPackage haskell/clafer-0.5-besspin.nix {};
      };
    };
    ghc = haskellEnv.ghc;

    rEnv = pkgs.rWrapper.override {
      packages = with rPackages; [
        ggplot2
        reshape2
        geometry
        Matrix
      ];
    };

    racketEnv = callPackage racket/racket-env.nix {
      # `racket-env.nix` needs the original package-less `racket` from nixpkgs,
      # not the `racketEnv.withPackages` version defined below.
      inherit (pkgs) racket;
    };
    racket = racketEnv.withPackages (ps: with ps; [
      rosette toml bdd threading-lib
    ]);

    texliveEnv = texlive.combine { inherit (texlive) scheme-medium; };

    scalaEnv = callPackage scala/scala-env.nix {
      inherit (pkgs) scala sbt;
      overrides = self: super: {
        rocket-chip-config-plugin = self.callPackage besspin/rocket-chip-config-plugin.nix {};
      };
    };
    sbt = scalaEnv.withPackages (ps: with ps; [
      chisel3 firrtl hardfloat
      rocket-chip
      rocket-chip-config-plugin
      binDeps.chisel3-firrtl-hardfloat
      binDeps.rocket-chip
      binDeps.borer
      chisel-P1
      chisel-P2
      # Disabled pending tool-suite#63
      #boom
      #chisel-P3
    ]);


    # Other dependencies - binaries and C/C++ libraries.

    tinycbor = callPackage cxx/tinycbor.nix {};

    # These riscv-arch values are taken from the coremark -march flags for P1/P2
    riscv-gcc = callPackage misc/riscv-gcc.nix {};
    riscv-gcc-linux = callPackage misc/riscv-gcc.nix {
      targetLinux = true;
    };

    riscv-gcc-freebsd = callPackage misc/riscv-gcc-freebsd.nix {};

    # add additional libraries for riscv linux compiler
    riscv-libkeyutils = callPackage misc/riscv-keyutils.nix {};
    riscv-libpam = callPackage misc/riscv-pam.nix {};
    riscv-libcrypto = callPackage misc/riscv-openssl.nix {};

    riscvLlvmPackages = callPackage misc/riscv-clang.nix {
      llvmPackages_9 = pkgsForRiscvClang.llvmPackages_9;
    };
    riscv-llvm = riscvLlvmPackages.llvm;
    riscv-clang = riscvLlvmPackages.clang;
    riscv-lld = riscvLlvmPackages.lld;

    riscv32-newlib = callPackage misc/riscv-newlib.nix { riscvArch = "riscv32"; };
    riscv64-newlib = callPackage misc/riscv-newlib.nix { riscvArch = "riscv64"; };
    riscv-newlib = symlinkJoin {
      name = "riscv-newlib-combined";
      paths = [
        riscv32-newlib
        riscv64-newlib
      ];
    };

    riscv32-compiler-rt = callPackage misc/riscv-compiler-rt.nix { riscvArch = "riscv32"; };
    riscv64-compiler-rt = callPackage misc/riscv-compiler-rt.nix { riscvArch = "riscv64"; };

    riscv32-clang-baremetal-sysroot = symlinkJoin {
      name = "riscv32-unknown-elf-sysroot";
      paths = [
        riscv32-newlib
        riscv32-compiler-rt
      ];
    };

    riscv64-clang-baremetal-sysroot = symlinkJoin {
      name = "riscv64-unknown-elf-sysroot";
      paths = [
        riscv64-newlib
        riscv64-compiler-rt
      ];
    };


    riscv-zlib-freebsd = callPackage ./misc/riscv-zlib.nix {
      sysroot = freebsdSysroot;
      riscv-linker = riscv-lld;
      useLLD = true;
      crossPrefix="riscv64-unknown-freebsd12.1";
    };

    riscv-openssh-freebsd = callPackage ./misc/riscv-openssh.nix { 
      isFreeBSD=true; 
      sysroot = freebsdSysroot;
      crossPrefix="riscv64-unknown-freebsd12.1";
      riscv-zlib=riscv-zlib-freebsd;
    };

    riscv-gdb-freebsd = callPackage ./gfe/freebsd/riscv-gdb.nix {
      sysroot = freebsdSysroot;
      crossPrefix="riscv64-unknown-freebsd12.1";      
    };

    freebsd = callPackage ./gfe/freebsd {
      bmake = pkgsForRiscvClang.bmake;
      targetSsh = riscv-openssh-freebsd;
      targetGdb = riscv-gdb-freebsd;
    };

    inherit (freebsd) freebsdWorld freebsdKernelQemu freebsdKernelFpga
      freebsdDebugKernelQemu freebsdDebugKernelFpga freebsdSysroot
      freebsdImageConnectal freebsdKernelConnectal;

    riscv-openocd = callPackage misc/riscv-openocd.nix {};

    alloy-check = callPackage alloy-check/alloy-check.nix {};

    nametag = callPackage misc/nametag.nix {};

    debootstrap = callPackage misc/debootstrap.nix {};
    debianPortsArchiveKeyring = callPackage misc/debian-ports-archive-keyring.nix {};

    claferToolDir = callPackage misc/clafer-tool-dir.nix {};
    clafer = binWrapper misc/clafer {
      inherit bash claferToolDir;
      clafer = haskellEnv.clafer_0_5_besspin;
    };


    # BESSPIN tool suite components.

    configurator = callPackage besspin/configurator.nix {};
    configuratorWrapper = binWrapper besspin/besspin-configurator {
      inherit bash python3;
      clafer = haskellEnv.clafer_0_5_0;
      inherit configurator;
    };

    halcyonSrc = callPackage besspin/halcyon-src.nix {};
    halcyon = pkgs.writeShellScriptBin "besspin-halcyon"
      ''
        echo "besspin-halcyon no longer builds in nix due to the removal of verific.""
        false
      '';

    fesvr = callPackage misc/fesvr.nix {};
    riscvTimingTests = callPackage besspin/riscv-timing-tests.nix {};
    rvttSrc = callPackage besspin/riscv-timing-tests-src.nix {};
    rvttEnv = callPackage besspin/riscv-timing-tests-env.nix {
      inherit fesvr;
    };
    rvttPlotInt = binWrapper besspin/besspin-timing-plot-int {
      inherit bash rEnv rvttSrc;
    };
    rvttPlotFloat = binWrapper besspin/besspin-timing-plot-float {
      inherit bash rEnv rvttSrc;
    };
    rvttInterpolate = binWrapper besspin/besspin-timing-interpolate {
      inherit bash rEnv rvttSrc;
    };
    rvttUnpacker = unpacker {
      baseName = "timing-tests";
      longName = "BESSPIN RISC-V timing test source code";
      version = "0.1-${builtins.substring 0 7 rvttSrc.rev}";
      pkg = "${rvttEnv}";
    };

    aeSrc = callPackage besspin/arch-extract-src.nix {};
    aeDriver = callPackage besspin/arch-extract-driver.nix {};
    aeExportVerilog = pkgs.writeShellScriptBin "besspin-arch-extract-export-verilog"
      ''
        echo "besspin-arch-extract-export-verilog no longer builds in nix due to the removal of verific.""
        false
      '';
    bscSrc = callPackage ./bsc/src.nix {};
    bscExport = callPackage ./bsc {};

    bscBinary = callPackage ./bsc-binary.nix {};

    aeExportBsv = binWrapper besspin/besspin-arch-extract-export-bsv {
      inherit bash bscExport;
    };
    aeListBsvLibraries = binWrapper besspin/besspin-arch-extract-list-bsv-libraries {
      inherit bash bscExport;
    };
    firrtlExport = callPackage besspin/firrtl-export/firrtl-export.nix {
      inherit scalaEnv;
    };
    aeExportFirrtl = binWrapper besspin/firrtl-export/besspin-arch-extract-export-firrtl {
      inherit bash jre firrtlExport;
    };
    aeDriverWrapper = binWrapper besspin/besspin-arch-extract {
      inherit bash aeDriver aeExportVerilog aeExportBsv aeListBsvLibraries;
    };

    featuresynth = callPackage besspin/featuresynth.nix {};
    featuresynthWrapper = binWrapper besspin/besspin-feature-extract {
      inherit bash featuresynth racket;
    };
    fmtoolWrapper = binWrapper besspin/besspin-feature-model-tool {
      inherit bash featuresynth racket;
    };
    rocketChipConfigs = scalaEnv.callPackage besspin/rocket-chip-configs.nix {};
    rocketChipHelper = binWrapper besspin/besspin-rocket-chip-helper {
      inherit bash rocketChipConfigs;
      sbt = scalaEnv.withPackages (pkgs:
        [ rocketChipConfigs.origRocketChip ] ++
        rocketChipConfigs.allScalaDeps);
      rocketChipName = rocketChipConfigs.origRocketChip.fullName;
      rocketChipSrc = rocketChipConfigs.src;
      rocketChipExtraLibs = "";
      rocketChipGenerator = "galois.system.Generator";
      rocketChipTopModule = "galois.system.TestHarness";
    };
    boomConfigs = scalaEnv.callPackage besspin/boom-configs.nix {};
    boomHelper = binWrapperNamed "besspin-boom-helper"
        besspin/besspin-rocket-chip-helper {
      inherit bash;
      sbt = scalaEnv.withPackages (pkgs:
        [ boomConfigs.origBoom ] ++
        boomConfigs.allScalaDeps);
      rocketChipConfigs = boomConfigs;
      rocketChipName = boomConfigs.origBoom.fullName;
      rocketChipSrc = boomConfigs.src;
      rocketChipExtraLibs = boomConfigs.origBoom.rocket-chip.fullName;
      rocketChipGenerator = "boom.galois.system.Generator";
      rocketChipTopModule = "boom.system.TestHarness";
    };
    rocketChipCheckConfig = callPackage besspin/rocket-chip-check-config.nix {};
    rocketChipCheckConfigWrapper = binWrapper besspin/besspin-rocket-chip-check-config {
      inherit bash python3 rocketChipCheckConfig;
    };
    /*
    featuresynthConfigUnpacker = unpacker {
      baseName = "feature-extract-configs";
      longName = "BESSPIN feature model extraction configs for GFE processors";
      version = "0.1-${builtins.substring 0 7 aeSrc.rev}";
      pkg = "${aeSrc}/gfe-configs";
    };
    */


    coremarkSrc = callPackage besspin/coremark-src.nix {};
    coremarkP1 = callPackage besspin/coremark.nix {
      riscv-gcc = riscv-gcc;
      gfe-target = "P1";
    };
    coremarkP2 = callPackage besspin/coremark.nix {
      riscv-gcc = riscv-gcc-linux;
      gfe-target = "P2";
      iterations = "3000";
    };
    coremarkP3 = callPackage besspin/coremark.nix {
      riscv-gcc = riscv-gcc-linux;
      gfe-target = "P3";
      iterations = "1000";
    };
    coremarkBuilds = callPackage besspin/coremark-builds.nix {
      inherit coremarkP1 coremarkP2 coremarkP3;
    };
    coremarkSrcUnpacker = unpacker {
      baseName = "coremark-src";
      longName = "CoreMark source code";
      version = "0.1-${builtins.substring 0 7 coremarkSrc.rev}";
      pkg = "${coremarkSrc}";
    };
    coremarkBuildsUnpacker = unpacker {
      baseName = "coremark-builds";
      longName = "CoreMark binary builds";
      version = "0.1-${builtins.substring 0 7 coremarkSrc.rev}";
      pkg = "${coremarkBuilds}";
    };

    systemBuilder = builtins.filterSource
      (path: type: lib.any (ext: lib.hasSuffix ext path) [".py" ".md" ".cfg"])
      ../scripts/system-builder;
    buildPiccolo = binWrapper besspin/besspin-build-configured-piccolo {
      inherit bash coreutils python3 fmtoolWrapper systemBuilder;
    };

    mibenchSrc = callPackage besspin/mibench-src.nix {};
    mibenchP1 = callPackage besspin/mibench.nix {
      riscv-gcc = riscv-gcc;
      gfe-target = "P1";
    };
    mibenchP2 = callPackage besspin/mibench.nix {
      riscv-gcc = riscv-gcc-linux;
      gfe-target = "P2";
      # TODO: figure out why these two produce linker errors, and fix them
      skip-benches = [ "basicmath" "fft" ];
    };
    mibenchBuilds = callPackage besspin/mibench-builds.nix {
      inherit mibenchP1 mibenchP2;
    };
    mibenchSrcUnpacker = unpacker {
      baseName = "mibench-src";
      longName = "MiBench2 source code";
      version = "0.1-${builtins.substring 0 7 mibenchSrc.rev}";
      pkg = "${mibenchSrc}";
    };
    mibenchBuildsUnpacker = unpacker {
      baseName = "mibench-builds";
      longName = "MiBench2 binary builds";
      version = "0.1-${builtins.substring 0 7 mibenchSrc.rev}";
      pkg = "${mibenchBuilds}";
    };

    halcyonBoomUnpacker = unpacker {
      baseName = "halcyon-boom-verilog";
      longName = "prebuilt BOOM Verilog for use with Halcyon";
      version = "0.1-${builtins.substring 0 7 halcyonSrc.rev}";
      pkg = "${halcyonSrc}/processors/boom";
    };

    rocketChipBuildUnpacker = unpackerGfe {
      baseName = "rocket-chip-build";
      longName = "simple rocket-chip elaboration setup";
      version = "0.1";
      pkg = builtins.filterSource
        (path: type: lib.any (suf: lib.hasSuffix suf path) [
          "/.gitignore" "/Makefile" "/README.md" "/build.sbt"
          "/project" "/project/build.properties"
          ".scala"
        ])
        ../scripts/rocket-chip-build;
    };


    gfeSrc = callPackage gfe/gfe-src.nix {};

    bluespecP1Verilog = callPackage gfe/bluespec-verilog.nix {
      gfe-target = "P1";
      src = gfeSrc.modules."bluespec-processors/P1/Piccolo";
    };

    bluespecP2Verilog = callPackage gfe/bluespec-verilog.nix {
      gfe-target = "P2";
      src = gfeSrc.modules."bluespec-processors/P2/Flute";
    };

    bluespecP3Verilog = callPackage gfe/bluespec-verilog.nix {
      gfe-target = "P3";
      src = gfeSrc.modules."bluespec-processors/P3/Tuba";
    };

    bluespecP1Bitstream = callPackage gfe/bitstream.nix {
      gfe-target = "P1";
      processor-name = "bluespec";
      processor-verilog = bluespecP1Verilog;
    };

    bluespecP2Bitstream = callPackage gfe/bitstream.nix {
      gfe-target = "P2";
      processor-name = "bluespec";
      processor-verilog = bluespecP2Verilog;
    };

    bluespecP3Bitstream = callPackage gfe/bitstream.nix {
      gfe-target = "P3";
      processor-name = "bluespec";
      processor-verilog = bluespecP3Verilog;
    };

    programFpga = callPackage gfe/program-fpga.nix {
      inherit riscv-openocd;
      bitstreams = [
        bluespecP1Bitstream
        bluespecP2Bitstream
        bluespecP3Bitstream
      ];
    };
    programFpgaWrapper = binWrapper gfe/gfe-program-fpga {
      inherit bash python3 gawk coreutils programFpga;
    };

    clearFlash = callPackage gfe/clear-flash.nix {};
    clearFlashWrapper = binWrapper gfe/gfe-clear-flash {
      inherit bash clearFlash;
    };

    testingScripts = callPackage gfe/testing-scripts.nix {};
    runElf = binWrapper gfe/gfe-run-elf {
      inherit bash python3 testingScripts gfeSrc;
    };
    riscvTestsBuildUnpacker = unpacker {
      baseName = "riscv-tests-build";
      longName = "riscv-tests build system";
      version = "0.1-${builtins.substring 0 7 gfeSrc.modules.riscv-tests.rev}";
      pkg = callPackage gfe/riscv-tests-build.nix {};
    };

    simulatorBins = callPackage gfe/all-simulator-bins.nix {};

    debianRepoSnapshot = togglePackagePerf "debian-repo-snapshot"
      "1qpacdrf360y8dkir0cyb5xnwv2044iwsknx9dim7404wvbkh4pi"
      (callPackage misc/debian-repo-snapshot.nix {}) null;
    genInitCpio = callPackage gfe/gen-init-cpio.nix {};

    debianExtraPackages = callPackage misc/debian-extra-packages.nix {};

    riscvBusybox = callPackage gfe/riscv-busybox.nix {
      configFile = callPackage gfe/busybox-config.nix {};
    };

    mkLinuxImage = { linuxConfig, initramfs, gfePlatform ? "fpga" }:
      callPackage gfe/riscv-bbl.nix {
        payload = callPackage gfe/riscv-linux.nix {
          configFile = linuxConfig;
          inherit initramfs;
        };
        inherit gfePlatform;
      };

    mkCustomizableLinuxImage = name: args:
      besspinConfig.customize."linux-image-${name}" or (mkLinuxImage args);

    busyboxImage = mkCustomizableLinuxImage "busybox" {
      # NOTE temporarily using a custom config due to PCIE issues (tool-suite#52)
      #linuxConfig = callPackage gfe/linux-config-busybox.nix {};
      linuxConfig = gfe/busybox-linux.config;
      initramfs = callPackage gfe/busybox-initramfs.nix {};
    };
    busyboxImageQemu = mkCustomizableLinuxImage "busybox-qemu" {
      # NOTE temporarily using a custom config due to PCIE issues (tool-suite#52)
      #linuxConfig = callPackage gfe/linux-config-busybox.nix {};
      linuxConfig = gfe/busybox-linux.config;
      initramfs = callPackage gfe/busybox-initramfs.nix {};
      gfePlatform = "qemu";
    };

    chainloaderImage = mkCustomizableLinuxImage "chainloader" {
      linuxConfig = callPackage gfe/linux-config-chainloader.nix {};
      initramfs = callPackage gfe/chainloader-initramfs.nix {};
      gfePlatform = "qemu";
    };

    debianStage1Initramfs = callPackage gfe/debian-stage1-initramfs.nix {};

    riscv-zlib-linux = callPackage ./misc/riscv-zlib.nix {
      sysroot = "${riscv-gcc-linux}/sysroot";
      riscv-linker = riscv-gcc-linux;
      useLLD = false;
      crossPrefix="riscv64-unknown-linux-gnu";
    };

    riscv-openssh-linux = callPackage ./misc/riscv-openssh.nix { 
      isFreeBSD=false;
      sysroot = "${riscv-gcc-linux}/sysroot";
      crossPrefix="riscv64-unknown-linux-gnu";
      riscv-zlib=riscv-zlib-linux;
    };

    mkDebianImage = { targetSsh ? riscv-openssh-linux, gfePlatform, useRsyslog ? true }:
      mkCustomizableLinuxImage ("debian" + lib.optionalString (gfePlatform != null) "-${gfePlatform}") {
        # NOTE temporarily using a custom config due to PCIE issues (tool-suite#52)
        #linuxConfig = callPackage gfe/linux-config-debian.nix {};
        linuxConfig = gfe/debian-linux.config;
        initramfs = callPackage gfe/debian-initramfs.nix {
          extraSetup = callPackage besspin/debian-extra-setup.nix { inherit gfePlatform; };
          inherit targetSsh useRsyslog;
        };
        inherit gfePlatform;
      };

    debianImage = mkDebianImage { gfePlatform = "fpga"; };
    debianImageNoRsyslog = mkDebianImage { gfePlatform = "fpga"; useRsyslog = false; };
    debianImageQemu = mkDebianImage { gfePlatform = "qemu"; };
    debianImageFireSim = mkDebianImage { gfePlatform = "firesim"; };

    debianStandaloneKernel = { kernelCmdline ? null }: callPackage gfe/riscv-linux.nix {
      configFile = gfe/debian-linux.config;
      initramfs = null;
      inherit kernelCmdline;
    };

    debianKernelQemu = callPackage gfe/riscv-bbl.nix {
      payload = debianStandaloneKernel { };
      gfePlatform = "qemu";
    };

    debianKernelFireSim = callPackage gfe/riscv-bbl.nix {
      payload = debianStandaloneKernel { kernelCmdline = "root=/dev/iceblk"; };
      gfePlatform = "firesim";
    };

    debianRootfsQemu = callPackage gfe/debian-initramfs.nix {
      extraSetup = callPackage besspin/debian-extra-setup.nix {
        gfePlatform = "qemu";
        rootDeviceName = "vda";
      };
      buildDiskImage = true;
      targetSsh = riscv-openssh-linux;
    };

    debianRootfsFireSim = callPackage gfe/debian-initramfs.nix {
      extraSetup = callPackage besspin/debian-extra-setup.nix {
        gfePlatform = "firesim";
        rootDeviceName = "iceblk";
      };
      buildDiskImage = true;
      targetSsh = riscv-openssh-linux;
    };

    freebsdImageQemu = callPackage gfe/riscv-bbl.nix {
      payload = "${freebsdKernelQemu}/boot/kernel/kernel";
      gfePlatform = "qemu";
    };

    freebsdImage = callPackage gfe/riscv-bbl.nix {
      payload = "${freebsdKernelFpga}/boot/kernel/kernel";
    };

    freebsdDebugImageQemu = callPackage gfe/riscv-bbl.nix {
      payload = "${freebsdDebugKernelQemu}/boot/kernel/kernel";
      gfePlatform = "qemu";
    };

    freebsdDebugImage = callPackage gfe/riscv-bbl.nix {
      payload = "${freebsdDebugKernelFpga}/boot/kernel/kernel";
    };

    freebsdElfConnectal = callPackage gfe/riscv-bbl.nix {
      payload = "${freebsdKernelConnectal}/boot/kernel/kernel";
    };

    extractedArchitectures = callPackage besspin/extracted-architectures.nix {};
    extractedArchitecturesUnpacker = unpacker {
      baseName = "extracted-architectures";
      longName = "extracted architectures for GFE processors";
      version = "0.1";
      pkg = extractedArchitectures;
    };
  };
in lib.fix' (lib.extends overrides packages)
