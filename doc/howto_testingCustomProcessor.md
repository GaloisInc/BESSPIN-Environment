# How to test custom processor

This document enumerates the configurable options for incorporating your processor
into the system build and test harness tools within toolsuite.

## Creating a configuration file

To customize the toolsuite, create the file `~/.config/besspin/config.nix`. Use
[nix/default-user-config.nix](nix/default-user-config.nix) for
documentation on the supported configuration options.  After changing the
configuration, and after changing any external files referenced by the
configuration, you must restart the `nix-shell` to see the effects.

## Configuring bitstreams/simulators

By default, `testgen` runs its tests against the baseline GFE processor
designs that are packaged in the Nix shell.  However, you can configure the
tool suite to package bitstreams and simulators for an alternate design, and
`testgen` will test against that design instead.  To effect this customization
edit your `config.nix` with setting like the following:

```nix
{
    customize.bitstreams = /path/to/bitstreams-directory;

    customize.simulatorBins = {
        chisel_p1 = /path/to/chisel-p1-simulator-binary;
        chisel_p2 = /path/to/chisel-p2-simulator-binary;
        bluespec_p1 = /path/to/bluespec-p1-simulator-binary;
        bluespec_p2 = /path/to/bluespec-p2-simulator-binary;
        elf_to_hex = /path/to/elf-to-hex-binary;
    };
}
```

## Customizations via repository forks

Toolsuite uses a number of git-based projects and is set up to allow you to point
to your own fork of any of them to incorporate your own work into the project.

### Supported repositories

The set of repositories supported for customization is something that will change
over time. The best manner of discovering the currently supported set of repositories
is to set `traceFetch` to `true` in your config and then run the nix build process.

### Enabling forked repository

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
