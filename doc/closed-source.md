# Closed-source packages

This repository includes a few closed-source packages that are distributed only
in binary form.  For most users, it is impossible to build these packages from
source.  They can only be installed from the Nix binary cache on
`artifactory.galois.com`.

If your Nix installation is properly configured to use the binary cache, it
should download the necessary binaries automatically when running `nix-shell`.
See [this page](nix-cache.md) for configuration instructions.

For BESSPIN Tool Suite developers, [this page](closed-source-devs.md) describes
in more detail how closed-source tools are packaged.
