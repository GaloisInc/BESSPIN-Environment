# BESSPIN GFE image

This docker image is used for development targeting the SSITH
Government Furnished Equipment (GFE).  

The *BESSPIN-GFE* docker image is based upon the standard Linux for
systems engineering in BESSPIN, Debian/Linux 10 ("buster" release).

This image was originally developed in the 
[internal GFE repository](https://gitlab-ext.galois.com/ssith/gfe/-/tree/develop/docker) repository. 

This image is publicly available at: `galoisinc/besspin:gfe`.

## Contents

It contains most of the core development tools necessary for
interacting with SSITH projects and repositories (e.g., `git`,
`gnupg`, `openssl`, `ssh`, etc.), build and simulate software-based
versions of the GFE (`verilator`, `qemu`, etc.), and cross-compile
software targeting GFE platform variants (including `clang/llvm` and
`gcc`).

In particular, it contains the standard GCC and LLVM toolchains for RISC-V
processors. Programs in each GCC toolchain are prefixed with the name
of their target. The targets are:
- `riscv64-unknown-elf`
- `riscv64-unknown-linux-gnu`
- `riscv64-unknown-freebsd12.1`

The `riscv64-unknown-elf` target is for binaries running on bare
metal. Binaries compiled for this target will not run on Debian or
FreeBSD.

If you are using Clang, you will need to use the `--sysroot` flag to
specify the location of the headers and libraries for your target
platform. The sysroot locations on the GFE image are:
- `/opt/riscv-llvm/riscv32-unknown-elf` for 32-bit bare metal targets
- `/opt/riscv-llvm/riscv64-unknown-elf` for 64-bit bare metal targets
- `/opt/riscv-freebsd/sysroot` for FreeBSD targets
- `/opt/riscv/sysroot` for Linux targets

When using Clang and LLD, it is necessary to use the `-mno-relax`
flag, as LLD does not support linker relaxation for RISC-V targets.
It is worth mentioning that [the tool-suite environment file](https://github.com/GaloisInc/BESSPIN-Tool-Suite/tree/master/besspin/target/utils/defaultEnvUnix.mk) has all the flags that we use in various builds.

Typically when using this image one would mount either/both:
 - a local sandbox of the GFE repository in the host environment, or 
 - a local sandbox of whatever project you are building and testing
   on the GFE.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/gfe/Dockerfile).

This build takes many hours.

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s gfe
```

### Manually

To build the image:
```bash
DOCKER_BUILDKIT=1 docker build \
    --progress=plain \
    --tag galoisinc/besspin:gfe \
    .
```

To publish it:
```bash
docker push galoisinc/besspin:gfe
```
