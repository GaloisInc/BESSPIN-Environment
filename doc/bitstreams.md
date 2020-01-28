# Building Bitstreams with Nix

The tool suite includes Nix packages for building bitstreams
(currently just the Bluespec processors). Setting the
`precompiledBitstreams` option to `false` in your user config will
build these packages and use them in favor of the precompiled
bitstreams from the GFE repository. This option is set to `true` by
default, since synthesizing the bitstreams requires you to have the
Bluespec toolchain and Vivado (2019.1 or later) installed on your
machine. It is also necessary to make the following changes to your
configuration.

## Sandboxing

The licensing software that Vivado and BSC use will not work inside
the Nix sandbox, so the bitstream packages must be built with
sandboxing turned off. To do this, add the line

    sandbox = relaxed

to your `/etc/nix/nix.conf` configuration file and restart the Nix
daemon by running

    sudo systemctl restart nix-daemon.service

This will keep sandboxing on by default, but allow specific
derivations to be built without it.

More information about changing configuration options can be found in
the [Nix manual](https://nixos.org/nix/manual/#name-11).

## System Paths

Running BSC and Vivado involves some files outside of the Nix
store. You will need to modify the `systemFiles` options in your tool
suite configuration to point to the right paths. See the [default user
config file](nix/default-user-config.nix) for more information.

These paths get included in the package derivations, and therefore
affect the Nix store hashes. If you are developing on several machines
and want the store paths to be consistent, you should make sure that
these paths stay the same.
