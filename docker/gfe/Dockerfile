#syntax=docker/dockerfile-upstream:master-experimental
FROM debian:10

# Enable HTTPS support in wget and set nsswitch.conf to make resolution work within containers
RUN apt update \
    && apt install -y ssh openssl ca-certificates  \
    && echo hosts: dns files > /etc/nsswitch.conf \
    # make sure your domain is accepted
    && mkdir -p -m 0700 /root/.ssh/ \
    && apt install -y git software-properties-common wget gnupg vim \
    # General toolchain dependencies
    && apt install -y automake autotools-dev libmpc-dev libmpfr-dev libgmp-dev gawk \
    && apt install -y build-essential gperf patchutils zlib1g-dev libexpat-dev \
    # For riscv-linux build:
    && apt install -y curl openssl bc bison flex make autoconf debootstrap proot \
    && apt install -y libssl-dev debian-ports-archive-keyring device-tree-compiler \
    # RTL simulator and RISC-V emulator:
    && apt install -y verilator qemu qemu-user qemu-system-misc \
    # Needed for GDB
    && apt install -y libpython2.7 \
    # OpenOCD dependencies
    && apt install -y libftdi1-2 libusb-1.0-0-dev libtool pkg-config texinfo \
    # Needed for manual tests
    && apt install -y minicom \
    # System-wide python packages needed by testing scripts
    && apt install -y python3-pip \
    && pip3 install pyserial pexpect \
    # Xilinx vivado_lab dependency
    && apt install -y libtinfo5 \
    # Instal dependencies for FreeBSD
    && apt install -y libtool pkg-config cmake ninja-build samba texinfo libarchive-dev \
    && apt install -y libglib2.0-dev libpixman-1-dev libarchive-dev libarchive-tools libbz2-dev \
    # hexdump util
    && apt install -y bsdmainutils \
    # Install and configure TFTP server
    && apt install -y atftpd \
    && chmod 777 /srv/tftp

# RISC-V toolchains (both linux and newlib versions):
# Set PATH for RISCV-tools and LLVM Sysroot
ENV RISCV="/opt/riscv" \
    RISCV_LLVM="/opt/riscv-llvm" \
    LLVM_BIN_PATH="/opt/riscv-llvm/llvm-project/build/bin" \
    RISCV_C_INCLUDE_PATH="/opt/riscv/riscv64-unknown-elf/include" \
    PATH="/opt/riscv/bin:/opt/riscv-freebsd/bin:/opt/riscv-llvm/llvm-project/build/bin:/opt/Xilinx/Vivado_Lab/2019.1/bin:${PATH}" \
    GCC_TOOLCHAIN_SRC="/tmp/riscv-gnu-toolchain-gcc" \
    # LLVM Envs
    LLVM_PRJ_DIR="/opt/riscv-llvm/llvm-project" \
    NEWLIB_DIR="/tmp/riscv-newlib" \
    # FreeBSD Envs
    FREEBSD_DIR="/opt/riscv-freebsd" \
    FREEBSD_BUILD_DIR="/tmp/build-freebsd" \
    # Openocd
    OPENOCD_SRC="/tmp/riscv-openocd"

# Prepare for smoke runs
COPY smoke.c .

# ------------------------ Build gcc toolchain ------------------------
# Snapshot of master on 2019-10-10 -- update as needed
RUN git clone https://github.com/riscv/riscv-gnu-toolchain $GCC_TOOLCHAIN_SRC \
    && cd $GCC_TOOLCHAIN_SRC \
    && git checkout d5bea51083ec38172b84b7cd5ee99bfcb8d2e7b0 \
    && git submodule update --init --recursive \
    && ./configure --prefix /opt/riscv --enable-multilib --with-cmodel=medany --host=x86_64 \
    && make linux \
    && make \
    # smoke run
    && cd - \
    && riscv64-unknown-elf-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null \
    && riscv64-unknown-linux-gnu-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null \
    #clean up
    && rm -rf $GCC_TOOLCHAIN_SRC
# ------------------------------------------------------------------------

# ------------------------ Build LLVM ------------------------
# Snapshot of master on 2020-4-10
RUN git clone https://github.com/llvm/llvm-project.git $LLVM_PRJ_DIR \
        && cd $LLVM_PRJ_DIR \
        && git checkout 49e20c4c9efe1c0e74f9c0dc224a8014b93faa3c \
        && mkdir -p build \
        && cd build \
        && cmake -G Ninja \
            -DCMAKE_BUILD_TYPE=Release \
            -DLLVM_OPTIMIZED_TABLEGEN=OFF \
            -DLLVM_ENABLE_ASSERTIONS=ON \
            -DCLANG_DEFAULT_RTLIB=compiler-rt  \
            -DLLVM_ENABLE_PROJECTS="llvm;clang;lld" \
            ../llvm \
        && cmake --build . \
        # compile new lib Release 3.2.0
        && git clone https://github.com/riscv/riscv-newlib.git $NEWLIB_DIR \
        && cd $NEWLIB_DIR \
        && git checkout f289cef6be67da67b2d97a47d6576fa7e6b4c858 \
        && mkdir -p $NEWLIB_DIR/build32 \
        && cd $NEWLIB_DIR/build32 \
        && ../configure \
            CC_FOR_TARGET=clang \
            CFLAGS_FOR_TARGET="-target riscv32-unknown-elf -march=rv32im -mabi=ilp32 -mcmodel=medany -mno-relax -g -O2" \
            AR_FOR_TARGET=llvm-ar \
            RANLIB_FOR_TARGET=llvm-ranlib \
            --target=riscv32-unknown-elf \
            --with-newlib \
            --disable-libgloss \
            --prefix=$RISCV_LLVM \
        && make -j6 \
        && make install \
        # build64
        && mkdir -p $NEWLIB_DIR/build64 \
        && cd $NEWLIB_DIR/build64 \
        && ../configure \
            CC_FOR_TARGET=clang \
            CFLAGS_FOR_TARGET="-target riscv64-unknown-elf -march=rv64imac -mabi=lp64 -mcmodel=medany -mno-relax -g -O2" \
            AR_FOR_TARGET=llvm-ar \
            RANLIB_FOR_TARGET=llvm-ranlib \
            --target=riscv64-unknown-elf \
            --with-newlib \
            --disable-libgloss \
            --prefix=$RISCV_LLVM \
        && make -j6 \
        && make install \
        # Compile compiler-rt 
        #rt64
        && mkdir -p $LLVM_PRJ_DIR/build64-c_rt \
        && cd $LLVM_PRJ_DIR/build64-c_rt \
        && cmake -G Ninja \
            -DCMAKE_C_COMPILER=$LLVM_BIN_PATH/clang \
            -DCMAKE_AR=$LLVM_BIN_PATH/llvm-ar \
            -DCMAKE_NM=$LLVM_BIN_PATH/llvm-nm \
            -DCMAKE_RANLIB=$LLVM_BIN_PATH/llvm-ranlib \
            -DLLVM_CONFIG_PATH=$LLVM_BIN_PATH/llvm-config \
            -DCMAKE_C_FLAGS="-target riscv64-unknown-elf -march=rv64imac -mabi=lp64 -mcmodel=medany -mno-relax" \
            -DCMAKE_CXX_FLAGS="-target riscv64-unknown-elf -march=rv64imac -mabi=lp64 -mcmodel=medany -mno-relax" \
            -DCMAKE_ASM_FLAGS="-target riscv64-unknown-elf -march=rv64imac -mabi=lp64 -mcmodel=medany -mno-relax" \
            -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY \
            -DCMAKE_SYSROOT=$RISCV_LLVM/riscv64-unknown-elf \
            -DCOMPILER_RT_DEFAULT_TARGET_ARCH=riscv64 \
            -DCOMPILER_RT_DEFAULT_TARGET_TRIPLE=riscv64-unknown-elf \
            -DCOMPILER_RT_OS_DIR=baremetal \
            -DCOMPILER_RT_BAREMETAL_BUILD=ON \
            -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
            -DCOMPILER_RT_BUILD_XRAY=OFF \
            -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
            -DCOMPILER_RT_BUILD_PROFILE=OFF \
            ../compiler-rt \
        && cmake --build . \
        # Copy library to sysroot
        && cp \
            $LLVM_PRJ_DIR/build64-c_rt/lib/baremetal/libclang_rt.builtins-riscv64.a \
            $RISCV_LLVM/riscv64-unknown-elf/lib/ \
        #rt32
        && mkdir -p $LLVM_PRJ_DIR/build32-c_rt \
        && cd $LLVM_PRJ_DIR/build32-c_rt \
        && cmake -G Ninja \
            -DCMAKE_C_COMPILER=$LLVM_BIN_PATH/clang \
            -DCMAKE_AR=$LLVM_BIN_PATH/llvm-ar \
            -DCMAKE_NM=$LLVM_BIN_PATH/llvm-nm \
            -DCMAKE_RANLIB=$LLVM_BIN_PATH/llvm-ranlib \
            -DLLVM_CONFIG_PATH=$LLVM_BIN_PATH/llvm-config \
            -DCMAKE_C_FLAGS="-target riscv32-unknown-elf -march=rv32im -mabi=ilp32 -mcmodel=medany -mno-relax" \
            -DCMAKE_CXX_FLAGS="-target riscv32-unknown-elf -march=rv32im -mabi=ilp32 -mcmodel=medany -mno-relax" \
            -DCMAKE_ASM_FLAGS="-target riscv32-unknown-elf -march=rv32im -mabi=ilp32 -mcmodel=medany -mno-relax" \
            -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY \
            -DCMAKE_SYSROOT=/opt/riscv-llvm/riscv32-unknown-elf \
            -DCOMPILER_RT_DEFAULT_TARGET_ARCH=riscv32 \
            -DCOMPILER_RT_DEFAULT_TARGET_TRIPLE=riscv32-unknown-elf \
            -DCOMPILER_RT_OS_DIR=baremetal \
            -DCOMPILER_RT_BAREMETAL_BUILD=ON \
            -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
            -DCOMPILER_RT_BUILD_XRAY=OFF \
            -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
            -DCOMPILER_RT_BUILD_PROFILE=OFF \
            ../compiler-rt \
        && cmake --build . \
        # Copy library to sysroot
        && cp \
            $LLVM_PRJ_DIR/build32-c_rt/lib/baremetal/libclang_rt.builtins-riscv32.a \
            $RISCV_LLVM/riscv32-unknown-elf/lib/ \
        # Some more links to finalize the installations
        && mkdir -p $RISCV_LLVM/llvm-project/build/lib/clang/11.0.0/lib \
        && ln -s $RISCV_LLVM/riscv64-unknown-elf/lib $RISCV_LLVM/llvm-project/build/lib/clang/11.0.0/lib/linux \
        # smoke run (clang/gcc + clang/lld) + clean up)
        && cd / \
        && clang \
            -target riscv64-unknown-linux-gnu \
            --sysroot=$(riscv64-unknown-linux-gnu-gcc -print-sysroot) \
            -march=rv64imafdc -mabi=lp64d -c -o smoke.o smoke.c \
            && riscv64-unknown-linux-gnu-gcc -o /dev/null -march=rv64imafdc -mabi=lp64d smoke.o \
        && clang \
            -target riscv64-unknown-linux-gnu -march=rv64imafdc -mabi=lp64d \
            --sysroot=$(riscv64-unknown-linux-gnu-gcc -print-sysroot) \
            -L$(dirname $(riscv64-unknown-linux-gnu-gcc -print-libgcc-file-name)) \
            -B$(dirname $(riscv64-unknown-linux-gnu-gcc -print-libgcc-file-name)) \
            smoke.c -o /dev/null \
        # Clean up
        && rm -rf smoke.o $RISCV_LLVM/llvm-project/.git $NEWLIB_DIR
# ------------------------------------------------------------------------

COPY freebsd $FREEBSD_BUILD_DIR

# ------------------------ Build freebsd toolchain ------------------------
# Env + copy files
RUN cd $FREEBSD_BUILD_DIR \
        && git clone https://github.com/CTSRD-CHERI/cheribsd.git \
        && cd cheribsd \
        && git checkout e75a79b70e377faf1355100961c91784c6c77585 \
        && cd $FREEBSD_BUILD_DIR \
        && make clean \
        && TOOLCHAIN= make $PWD/world

# These values cannot be set before building the freebsd world --> 2 mandatory extra layers
ENV FREEBSD_TOOLCHAIN_SRC="/tmp/riscv-gnu-toolchain-freebsd" \
    SYSROOT="/opt/riscv-freebsd/sysroot" \
    OSREL="12.1"

# Build the toolchain
RUN mkdir -p $SYSROOT/usr \
        && cp -r $FREEBSD_BUILD_DIR/world/usr/lib $FREEBSD_BUILD_DIR/world/usr/include $SYSROOT/usr \
        && cp -r $FREEBSD_BUILD_DIR/world/lib $SYSROOT \
        # riscv-gnu
        && git clone https://github.com/freebsd-riscv/riscv-gnu-toolchain.git $FREEBSD_TOOLCHAIN_SRC \
        && cd $FREEBSD_TOOLCHAIN_SRC \
        && git checkout 1505830a3b757b3e65c15147388dd1a91ee2c786 \
        && git submodule update --init --recursive \
        && ./configure --prefix $FREEBSD_DIR \
        && make clean \
        && make freebsd OSREL=$OSREL SYSROOT=$SYSROOT \
        # smoke run + clean up (last use of smoke.c)
        && cd / \
        && clang \
                -target riscv64-unknown-freebsd12.1 -march=rv64imafdc -mabi=lp64d \
                --sysroot=$SYSROOT -Wno-error=sign-compare -mno-relax -fuse-ld=lld \
                smoke.c -o /dev/null \
        && rm -rf $FREEBSD_TOOLCHAIN_SRC $FREEBSD_BUILD_DIR smoke.c
# ------------------------------------------------------------------------

# ------------------------ Build openocd ------------------------
# This also needs to be changed prior to openocd
RUN git clone https://github.com/GaloisInc/BESSPIN-riscv-openocd.git $OPENOCD_SRC \
        && cd $OPENOCD_SRC \
        && git checkout 27c0fd7a7504087e6d8b6158a149b531bda9260d \
        && git submodule update --init --recursive \
        && ./bootstrap \
        && ./configure --enable-remote-bitbang --enable-jtag_vpi --enable-ftdi \
        && make \
        && make install \
        # clean-up
        && rm -rf $OPENOCD_SRC
# ------------------------------------------------------------------------

WORKDIR /gfe

