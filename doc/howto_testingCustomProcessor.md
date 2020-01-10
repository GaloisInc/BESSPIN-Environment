# How To Test Custom Processor

This document enumerates the configurable options for incorporating your processor
into the system build and test harness tools within toolsuite.

Customizing toolsuite for your processor involves two steps:

1) creating/editing a nix configuration file to customize the system build to your processor
2) editing the testgen configuration file to run the appropriate tests against your processor

## Step One: Nix Configuration File

The nix configuration file is used to specifiy the locations for bitstreams, riscv-gnu-toolchain,
rocket-chip sources, as well as the git repositories/revisions for related projects.

To customize the toolsuite, create the file `~/.config/besspin/config.nix`. Use
[nix/default-user-config.nix](nix/default-user-config.nix) for
documentation on the supported configuration options.  After changing the
configuration, and after changing any external files referenced by the
configuration, you must restart the `nix-shell` to see the effects.

### Configuring Bitstreams

By default, `testgen` runs its tests against the baseline GFE processor
designs that are packaged in the Nix shell.  However, you can configure the
tool suite to package bitstreams for an alternate design, and `testgen` will
test against that design instead.  To effect this customization
edit your `config.nix` with setting like the following:

```nix
{
    customize.bitstreams = /path/to/bitstreams-directory;
}
```

### Customizations Via Repository Forks

Toolsuite uses a number of git-based projects and is set up to allow you to point
to your own fork of any of them to incorporate your own work into the project.

#### Supported Repositories

The set of repositories supported for customization is something that will change
over time. The best manner of discovering the currently supported set of repositories
is to set `traceFetch` to `true` in your config and then run the nix build process.

#### Enabling Forked Repository

In order to enable toolsuite to leverage a custom fork of one of the supported
repositories you will need to override it in the `gitSrcs` section of your
`config.nix` file like so:

```nix
{
  gitSrcs = {
    # Use the HEAD commit of `~/repo1` instead of fetching the pinned
    # revision from Gitlab.
    "git@gitlab-ext.galois.com:ssith/repo1.git" = "/home/me/repo1";

    # Use the HEAD commit of `~/repo2`, but only to replace commit
    # `00112233445566778899aabbccddeeff00112233`.  Other references to
    # `repo2` will continue to use the pinned revision.
    "git@gitlab-ext.galois.com:ssith/repo2.git#00112233445566778899aabbccddeeff00112233" ="/home/me/repo2";

    # Fetch revision `aabbccddeeff0011223300112233445566778899` from
    # `my-branch` Gitlab, instead of using the normal pinned revision.
    "git@gitlab-ext.galois.com:ssith/repo3.git" = {
      url = "git@gitlab-ext.galois.com:ssith/repo3.git";
      rev = "aabbccddeeff0011223300112233445566778899";
      ref = "my-branch";
    };

    # Use the HEAD commit of `~/repo4`, but only when building `some-package`.
    # All other packages will use the normal URL.
    "git@gitlab-ext.galois.com:ssith/repo4.git%some-package" = "/home/me/repo4";
  };
}
```

*NOTE:* once you have made the change, it is wise to set `traceFetch` to `true` in your config,
monitoring the output to verify your custom repos is indeed being used.

### Configuring Simulators

By default, `testgen` runs its tests against the baseline GFE processor
designs that are packaged in the Nix shell.  However, you can configure the
tool suite to package simulators for an alternate design, and `testgen` will
test against that design instead.  To effect this customization
edit your `config.nix` with setting like the following:

```nix
{
    customize.simulatorBins = {
        chisel_p1 = /path/to/chisel-p1-simulator-binary;
        chisel_p2 = /path/to/chisel-p2-simulator-binary;
        bluespec_p1 = /path/to/bluespec-p1-simulator-binary;
        bluespec_p2 = /path/to/bluespec-p2-simulator-binary;
        elf_to_hex = /path/to/elf-to-hex-binary;
    };
}
```

## Step Two: Customizing Testgen

This section has a brief summary about how to customize the tests platform to a secure processor. More details could be found in [the testgen repo](https://gitlab-ext.galois.com/ssith/testgen).

### OS Images ###

Testgen can be configured to fetch the OS image either from Nix or from its local cache. If nix is to be used (default option), then check the details in the beginning of this document of how to customize the build path and such. The local cache option provides a manual control over which binary to use. 

*Note:* This is solely for Linux options, i.e. Busybox, FreeBSD, and Debian. FreeRTOS has to be re-built.

### Compiling Tests ###

Testgen has a default compilation path that either uses a simple cross-compiling Makefile, or uses a qemu instance to compile more sophisticated tests, based on which vulnerability class is being tested. However, if the `useCustomCompiling` setting is switched on, testgen can be configured to do either of the following:   
- Cross-compile using a user-defined Makefile.
- Cross-compile using a user-defined executable script. This means that testgen can be instructed to execute a user-defined shell script to handle the whole cross-compilation process. This provides the user with an extreme level of flexibility without the need to modify the tool itself.
- Compile within a Qemu instance using a user-defined Makefile.
- Compile within a Qemu instance using a user-defined executable script.

### Scoring Tests ###

Testgen has a default scoring mechanism that varies depending on the class, test, or even the OS on which the test is being run. However, if the `useCustomScoring` setting is switched on, testgen can be configured to do any of the following:   
- Score based on a certain set of user-defined keywords on STDOUT.
- Score based on a certain set of user-defined keywords on the output of GDB. These can include signals such as SIGTRAP or SEGFAULT.
- Score based on a certain set of checkpoints. These checkpoints could be system functions, methods, interrupts, or exceptions.
- Score based on the value of a specific memory location.
- Score based on a user-defined python module. This provides the user with a broad level of flexibility in designing any parser or pattern matcher without the need to modify the tool itself.

### Selective Tests Runs ###

Testgen, by default, runs all developed tests in each class. However, it can be configured to use a subset of the available tests by manipulating the local configuration (`configCWEs.ini`). This configuration file can be manipulated by the `testgen/scripts/configCWEs.py` tool. 

*Note:* We are developing a *vulnerability configurator* option. Hopefully, this will be included in the first Beta release in the end of January 2020. This will allow users to configure the tests selection using more abstract concepts than the inconvenient CWEs representation.
