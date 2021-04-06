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
ENV BSP_RISCV_PATH="/opt/riscv/bin:/opt/riscv-freebsd/bin:/opt/riscv-freebsd/riscv64-unknown-freebsd12.1/bin:/opt/riscv-llvm/llvm-project/build/bin"
ENV BSP_VIVADO_PATH="/opt/Xilinx/Vivado_Lab/2019.1/bin"
ENV PATH="${BSP_RISCV_PATH}:${BSP_VIVADO_PATH}:${PATH}"

WORKDIR /gfe

