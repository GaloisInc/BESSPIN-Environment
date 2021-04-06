FROM debian:10

# Enable HTTPS support in wget and set nsswitch.conf to make resolution work within containers
RUN apt-get update
RUN apt-get install -y ssh openssl ca-certificates  \
  && echo hosts: dns files > /etc/nsswitch.conf

# make sure your domain is accepted
RUN mkdir -p /root/.ssh/ && touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN apt-get install -y git
RUN apt-get install -y software-properties-common wget
RUN apt-get install -y gnupg
RUN apt-get install -y vim

# Install dependencies
# General toolchain dependencies
RUN apt-get install -y automake autotools-dev libmpc-dev libmpfr-dev libgmp-dev gawk
RUN apt-get install -y build-essential gperf patchutils zlib1g-dev libexpat-dev

# For riscv-linux build:
RUN apt-get install -y curl openssl bc bison flex make autoconf debootstrap proot
RUN apt-get install -y libssl-dev debian-ports-archive-keyring device-tree-compiler

# RTL simulator and RISC-V emulator:
RUN apt-get install -y verilator qemu qemu-user qemu-system-misc

# Needed for GDB
RUN apt-get install -y libpython2.7

# OpenOCD dependencies
RUN apt-get install -y libftdi1-2 libusb-1.0-0-dev libtool pkg-config texinfo

# Needed for manual tests
RUN apt-get install -y minicom

# System-wide python packages needed by testing scripts
RUN apt-get install -y python3-pip
RUN pip3 install pyserial pexpect

# Xilinx vivado_lab dependency
RUN apt-get install -y libtinfo5

# Instal dependencies for FreeBSD
RUN apt-get install -y libtool pkg-config cmake ninja-build samba texinfo libarchive-dev
RUN apt-get install -y libglib2.0-dev libpixman-1-dev libarchive-dev libarchive-tools libbz2-dev

# hexdump util
RUN apt-get install -y bsdmainutils

# Install and configure TFTP server
RUN apt-get install -y atftpd
RUN chmod 777 /srv/tftp

# Prepare for smoke runs
COPY smoke.c .

# Clang and LLVM for RISC-V:
RUN wget https://apt.llvm.org/llvm.sh
RUN chmod +x llvm.sh
RUN ./llvm.sh 10
RUN rm llvm.sh

# Set llvm symlinks and variables
RUN cd /usr/bin && ln -s clang-10 clang
RUN cd /usr/bin && ln -s clang++-10 clang++
RUN cd /usr/bin && ln -s clang-cpp-10 clang-cpp
RUN cd /usr/bin && ln -s ld.lld-10 ld.lld
RUN cd /usr/bin && ln -s llvm-objcopy-10 llvm-objcopy
RUN cd /usr/bin && ln -s llvm-objdump-10 llvm-objdump
RUN cd /usr/bin && ln -s llvm-ar-10 llvm-ar
RUN cd /usr/bin && ln -s llvm-ranlib-10 llvm-ranlib

# RISC-V toolchains (both linux and newlib versions):
# Set PATH for RISCV-tools and LLVM Sysroot
ENV RISCV="/opt/riscv"
ENV RISCV_LLVM="/opt/riscv-llvm"
ENV RISCV_C_INCLUDE_PATH="/opt/riscv/riscv64-unknown-elf/include"
ENV BSP_RISCV_PATH="/opt/riscv/bin:/opt/riscv-freebsd/bin:/opt/riscv-llvm/llvm-project/build/bin"
ENV BSP_VIVADO_PATH="/opt/Xilinx/Vivado_Lab/2019.1/bin"
ENV PATH="${BSP_RISCV_PATH}:${BSP_VIVADO_PATH}:${PATH}"

# ------------------------ Build freebsd toolchain ------------------------
# Env + copy files
ENV FREEBSD_DIR="/opt/riscv-freebsd"
ENV FREEBSD_BUILD_DIR="/tmp/build-freebsd/"
ENV FREEBSD_TOOLCHAIN_SRC="/tmp/riscv-gnu-toolchain-freebsd"
RUN mkdir -p $FREEBSD_BUILD_DIR
COPY freebsd $FREEBSD_BUILD_DIR

# Clone cheribsd + make world
RUN cd $FREEBSD_BUILD_DIR \
        && git clone https://github.com/CTSRD-CHERI/cheribsd.git \
        && cd cheribsd \
        && git checkout e75a79b70e377faf1355100961c91784c6c77585
RUN cd $FREEBSD_BUILD_DIR \
        && make clean \
        && TOOLCHAIN= make $PWD/world

# Build the toolchain
ENV SYSROOT="$FREEBSD_DIR/sysroot"
ENV OSREL="12.1"
RUN mkdir -p $SYSROOT/usr \
        && cp -r $FREEBSD_BUILD_DIR/freebsd/world/usr/lib $FREEBSD_BUILD_DIR/freebsd/world/usr/include $SYSROOT/usr
RUN git clone https://github.com/freebsd-riscv/riscv-gnu-toolchain.git $FREEBSD_TOOLCHAIN_SRC \
        && cd $FREEBSD_TOOLCHAIN_SRC \
        && git checkout 1505830a3b757b3e65c15147388dd1a91ee2c786 \
        && git submodule update --init --recursive
RUN cd $FREEBSD_TOOLCHAIN_SRC \
        && ./configure --prefix $FREEBSD_DIR \
        && make clean \
        && make freebsd OSREL=$OSREL SYSROOT=$SYSROOT

# smoke run + clean up
RUN clang -target riscv64-unknown-freebsd12.1 -march=rv64imafdc -mabi=lp64d --sysroot=$SYSROOT -Wno-error=sign-compare -mno-relax -fuse-ld=lld -o /dev/null
RUN rm -rf $FREEBSD_TOOLCHAIN_SRC $FREEBSD_BUILD_DIR
# ------------------------------------------------------------------------

# ------------------------ Build gcc toolchain ------------------------
ENV GCC_TOOLCHAIN_SRC="/tmp/riscv-gnu-toolchain-gcc"
# Snapshot of master on 2019-10-10 -- update as needed
RUN git clone https://github.com/riscv/riscv-gnu-toolchain $GCC_TOOLCHAIN_SRC \
        && cd $GCC_TOOLCHAIN_SRC \
        && git checkout d5bea51083ec38172b84b7cd5ee99bfcb8d2e7b0 \
        && git submodule update --init --recursive

RUN cd $GCC_TOOLCHAIN_SRC \
        && ./configure --prefix /opt/riscv --enable-multilib --with-cmodel=medany --host=x86_64 \
        && make linux \
        && make

# smoke run + clean up
RUN riscv64-unknown-elf-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null
RUN riscv64-unknown-linux-gnu-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null
RUN clang -target riscv64-unknown-linux-gnu -march=rv64imafdc -mabi=lp64d --sysroot=$(shell riscv64-unknown-linux-gnu-gcc -print-sysroot) -fuse-ld=lld -o /dev/null
RUN rm -rf $GCC_TOOLCHAIN_SRC
# ------------------------------------------------------------------------

# ------------------------ Build openocd ------------------------
ENV OPENOCD_SRC="/tmp/riscv-openocd"
RUN git clone git@gitlab-ext.galois.com:ssith/riscv-openocd.git $OPENOCD_SRC \
        && cd $OPENOCD_SRC \
        && git checkout 27c0fd7a7504087e6d8b6158a149b531bda9260d \
        && git submodule update --init --recursive
RUN cd $OPENOCD_SRC \
        && ./bootstrap \
        && ./configure --enable-remote-bitbang --enable-jtag_vpi --enable-ftdi \
        && make \
        && make install
RUN rm -rf $OPENOCD_SRC
# ------------------------------------------------------------------------

# Clean smoke.c
RUN rm smoke.c

WORKDIR /gfe

