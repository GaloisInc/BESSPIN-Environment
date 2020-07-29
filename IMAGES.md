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
explains how to update the binary cache, which is important to do
after rebuilding any OS images.

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

4. Build the `buildkernel` and target to compile the FreeBSD
   kernel. If we are targeting a platform which requires us to have
   the root filesystem be a ramdisk compiled into the kernel, follow
   the instructions in the
   [`md(4)`](https://www.freebsd.org/cgi/man.cgi?query=md&sektion=4)
   man page.

5. Build BBL, configured for the target platform, with the FreeBSD
   kernel as the payload.

The FreeBSD source is defined in `nix/gfe/gfe-src.nix`. Since the
upstream version of FreeBSD does not support cross compilation from
Linux hosts, we use the `freebsd-crossbuild` branch of the CheriBSD
repo.

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
`/etc/fstab` uses the correct device name for the root filesystem.
