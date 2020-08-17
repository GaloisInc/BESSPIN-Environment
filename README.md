# The FETT Environment

This software environment provides toolchains, images, and environment variables--managed with the Nix package manager--needed to use FETT projects. Currently, it is under development, with bugs and missing features.

## Installation/Usage

1. **Install Nix**: The environment requires the [Nix package manager](https://nixos.org/nix/).  To
   install it, follow [these instructions](https://nixos.org/nix/manual/#sect-multi-user-installation).

2. **Enter the Nix Shell**: Run

   ```
   $ nix-shell
   ```

   in the root directory of the repository. Initially, Nix make spend several minutes setting up the environment for first time use. Subsequent reruns of `nix-shell` will cause nix to start in a few seconds.

   Note that additional shells can be found in `nix/dev`. They can be used by running

   ```
   $ nix-shell nix/dev/<NAME>.nix
   ```

3. **Use the Tools/Images/Variables**
   * `riscv64-unknown-linux-gnu`, `riscv64-unknown-freebsd12.1`GCC/Clang toolchains, with cross builds for `pam` and `keyutils` libraries.
   * `python3` environment, with necessary packages for FETT projects.
   * Debian/Busybox/FreeBSD Images for qemu, fpga, located at `FETT_GFE_DEBIAN_FPGA`, `FETT_GFE_DEBIAN_QEMU`, `FETT_GFE_FREEBSD_FPGA`, `FETT_GFE_FREEBSD_QEMU`, `FETT_GFE_BUSYBOX_FPGA` and `FETT_GFE_BUSYBOX_QEMU`.

## Development

See [here](./IMAGES.md) for information on how the OS images are built.
