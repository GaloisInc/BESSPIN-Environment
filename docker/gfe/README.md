# GFE Docker Image

This image, available on Docker Hub as `galoisinc/besspin:gfe`,
contains the standard GCC and LLVM toolchains for RISC-V
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

## Building the Vanilla GFE toolchain image





