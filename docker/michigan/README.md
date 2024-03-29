# Michigan toolchain docker image #

## Building the docker image

To be built using the dockerfile provided.

For any support or binaries requests, please contact University of Michigan. This image is not supported by `build-docker.py`or Galois.

## Building FreeRTOS apps with the Morpheus platform

The toolchain (clang binaries + sysroot + ELF encryption binary) is provided in `llvm-build/`.
FreeRTOS build is provided in `FreeRTOS-10.0.1/`.

Steps for building apps are detailed below.

(1) Set the following environment variables:
    (a) For RISC-V (just like the original GFE documentation)
        `export RISCV=<riscv_install_dir>/riscv`
        `export RISCV_C_INCLUDE_PATH=$RISCV/riscv64-unknown-elf/include`
        `export PATH=$RISCV/bin:$PATH`
    (b) For Morpheus clang and sysroot
        `export EMTD_PREFIX=<path_to_this_directory>/llvm-build`
        `export SYSROOT_DIR=$EMTD_PREFIX/clang_sysroot/riscv32-unknown-elf`
        `export PATH="$EMTD_PREFIX/bin/:$PATH"`

(2) Use the provided FreeRTOS version which contains support for the Morpheus platform
    (branch `umich_develop` created from branch `develop` commit 3adde0d (06-17-20))

(3) Build the app (example for main_blinky)
        `export PROG=main_blinky BSP=aws USE_CLANG=yes USE_MORPHEUS=yes`
        `make clean && make`

(4) Once the app is built, encrypt the binary
        `elf-parser -e main_blinky.elf`
    The elf-parser tool is present in `$EMTD_PREFIX/bin` and should be in the PATH already.
    This tool will encrypt the ELF file in place (i.e. won't generate a new file).

    Note that the tools on this image will encrypt binaries with a
    different key than the one required to run code on the Michigan
    BESSPIN instances.
