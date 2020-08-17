# Building OS Images

## Background

Making substantial changes to the FETT Environment will require an
understanding of Nix. One good introduction is through the [Nix
Pills](https://nixos.org/nixos/nix-pills/), a set of short lessons
which cover the most important features of the package manager and
language. For a more thorough reference, consult the [Nix
Manual](https://nixos.org/nix/manual/). Most Nix packages, including
the ones in this repository, rely heavily on the build evironment
provided by Nixpkgs, which is documented in the [Nixpkgs
Manual](https://nixos.org/nixpkgs/manual/).

The [BESSPIN Tool Suite
documentation](https://gitlab-ext.galois.com/ssith/tool-suite/-/tree/master/doc)
covers some of the specific tricks used in these packages. The
[release
documentation](https://gitlab-ext.galois.com/ssith/tool-suite/-/blob/master/doc/release.md)
explains how to update the binary cache, which is required
after rebuilding any OS images.

## Target Platforms

Many of the packages referenced in the rest of this document take an
argument, usually called `gfePlatform`, which specifies the target
platform. The current choices for this are:

- `qemu`
- `fpga`
- `firesim` (Debian only)
- `connectal` (FreeBSD only)

## FreeBSD

Our build process for FreeBSD roughly follows the
[instructions](https://wiki.freebsd.org/riscv#Instructions) from the
FreeBSD wiki for cross compiling FreeBSD for RISC-V. The general steps are:

1. Set up the correct environment variables and `bmake` flags so that
   the build system knows where to find our cross compilation
   toolchain.

2. Build the `buildworld`, `installworld`, and `distribution` targets
   to compile and install all of the user-space components of FreeBSD.

3. Use `makefs` to create a filesystem image containing the products
   of the previous step, along with some important files like
   `/etc/fstab` and `/etc/rc.conf`.

4. Build the `buildkernel` target to compile the FreeBSD
   kernel. If the target platform requires the root filesystem to be
   compiled into the kernel, follow the instructions in the
    [`md(4)`](https://www.freebsd.org/cgi/man.cgi?query=md&sektion=4)
   man page.

5. Build BBL, configured for the target platform, with the FreeBSD
   kernel as the payload.

The FreeBSD source is defined in `nix/gfe/gfe-src.nix`. Since the
upstream version of FreeBSD does not support cross compilation from
Linux hosts, we use the `freebsd-crossbuild` branch of the [CheriBSD
project](https://github.com/CTSRD-CHERI/cheribsd/tree/freebsd-crossbuild).

The Nix files for the FreeBSD packages can be found in the directory
`nix/gfe/freebsd`. We define a
[function](./nix/gfe/freebsd/freebsd.nix) `mkFreebsdDerivation`, which
is a wrapper around `stdenv.mkDerivation` that patches the FreeBSD
build scripts to make everything work inside the Nix sandbox and then
builds some specified `bmake` targets. We the use this to implement
separate packages for the
[kernel](./nix/gfe/freebsd/freebsd-kernel.nix) and
[userspace](./nix/gfe/freebsd/freebsd-world.nix). Two packages depend
directly on the userspace package; one for building the [root
filesystem image](./nix/gfe/freebsd/freebsd-rootfs-image.nix) and
another for building a [sysroot](./nix/gfe/freebsd/sysroot.nix).

Adding a new GFE platform for FreeBSD is typically just a matter of
making sure that the kernel and BBL are configured properly, and that
`/etc/fstab` uses the correct device name for the root
filesystem. Making changes to the files that are on the image is
typically done by modifying the root filesystem package. See the
[OpenSSH package](./nix/misc/riscv-openssh.nix) for an example of
something which is installed on the FreeBSD images.

If building the root filesystem image fails with an error from
`makefs`, this is likely because there is not enough space on the
image. The size of the image is controlled by the `imageSize` argument
of the package.

## Debian

The Debian images are built using
[debootstrap](https://manpages.debian.org/unstable/debootstrap/debootstrap.8.en.html),
which is typically run in two stages. The first stage installs enough
software to run the second stage, which installs the full base system.
The Debian packages in the FETT environment are built using the
following steps.

1. Build a [chainloader image](./nix/gfe/chainloader-initramfs.nix). This is a busybox-based Linux image
   that runs a [simple
   init](https://gitlab-ext.galois.com/ssith/gfe/-/blob/develop/bootmem/chainloader-init)
   to unpack a second initramfs and switch to it. You probably don't
   have a reason to modify the
   [package](./nix/gfe/chainloader-initramfs.nix).

2. Run stage 1 of `debootstrap` to build an
   [initramfs](./nix/gfe/debian-stage1-initramfs.nix) with a [custom
   init](https://gitlab-ext.galois.com/ssith/gfe/-/blob/develop/debian/stage1-init)
   that runs stage 2 of `debootstrap`, does the remaining setup, and
   builds a `cpio` archive of the whole root filesystem. In the FETT
   environment, this is [patched](./nix/gfe/debian-image.patch) so
   that, depending on the kernel command line, it will create an
   filesystem image rather than a `cpio` archive.

3. Assemble the stage 1 initramfs, [GFE setup
   scripts](https://gitlab-ext.galois.com/ssith/gfe/-/tree/develop/debian/setup_scripts),
   and a [snapshot](./nix/misc/debian-repo-snapshot.nix) of the Debian
   package repo into a single [package](./nix/gfe/debian-stage1-virtual-disk.nix).

4. Build the [root filesystem package](./nix/gfe/debian-initramfs.nix)
   by booting the initramfs from step 2 with the chainloader from step
   1 using QEMU. This will result in either a `cpio` archive or a
   filesystem image, depending on the `buildDiskImage` argument. The
   `extraSetup` argument allows one to specify the location of an
   extra setup script to be run. For FETT-specific setup, we give it
   [this package](./nix/besspin/debian-extra-setup.nix), which
   produces a setup script depending on the target platform.

5. Build a [Linux kernel](./nix/gfe/riscv-linux.nix) with our [kernel
   config](./nix/gfe/debian-linux.config). The version of the kernel
   source is specified in the [GFE source](./nix/gfe/gfe-src.nix)
   package.

Making changes to the Debian images typically involves modifying BBL,
the Linux config, or the extra setup script described in step 4.

If there is some sort of error that prevents the stage 1 image from
shutting down, it is possible that the build in step 4 will not
terminate. Make sure to check for this if the Debian build takes even
longer than usual after updating the packages.

### Adding Packages

Installing packages on the Debian images can be tricky, since this
requires access to the Debian package repository. Downloading the
packages from the internet during the build phase of the Debian image
is not possible, but the entire repository is far too large to add as
a Nix package. Instead, we build a local copy containing only the
packages we need. The file `nix/misc/debian-repo-files.json` contains
a list of packages in their hashes, which we use to build the repo
snapshot. See
[`scripts/debian-archive-proxy.py`](./scripts/debian-archive-proxy.py)
and
[`scripts/update-debian-repo-files.py`](./scripts/update-debian-repo-files.py)
for more information about how to generate this file if you want to
add more packages.
