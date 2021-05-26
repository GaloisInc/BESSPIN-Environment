```
This material is based upon work supported by the Defense Advanced
Research Project Agency (DARPA) under Contract No. HR0011-18-C-0013. 
Any opinions, findings, conclusions or recommendations expressed in
this material are those of the author(s) and do not necessarily
reflect the views of DARPA.

Distribution Statement "A" (Approved for Public Release, Distribution
Unlimited)
```

# The BESSPIN Environment

This software environment provides toolchains, images, and environment variables--managed with the Nix package manager--needed to use BESSPIN projects. Currently, it is under development, with bugs and missing features.

Also, this repository has a the docker files for the various docker containers used by the BESSPIN tool-suite. 


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
   * `python3` environment, with necessary packages for BESSPIN projects.
   * Debian/Busybox/FreeBSD Images for qemu, fpga, located at `BESSPIN_GFE_DEBIAN_FPGA`, `BESSPIN_GFE_DEBIAN_QEMU`, `BESSPIN_GFE_FREEBSD_FPGA`, `BESSPIN_GFE_FREEBSD_QEMU`, `BESSPIN_GFE_BUSYBOX_FPGA` and `BESSPIN_GFE_BUSYBOX_QEMU`.

## Development

See [here](./IMAGES.md) for information on how the OS images are built.


## Docker 

Please see [docker/README.md](./docker/README.md).
