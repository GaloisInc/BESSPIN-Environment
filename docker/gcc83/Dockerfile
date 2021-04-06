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

# hexdump util
RUN apt-get install -y bsdmainutils

# Additional reqs
RUN apt-get install -y texinfo

# RISC-V toolchains (both linux and newlib versions):
# Set PATH for RISCV-tools and LLVM Sysroot
ENV RISCV="/opt/riscv"
ENV RISCV_C_INCLUDE_PATH="/opt/riscv/riscv64-unknown-elf/include"
ENV PATH="/opt/riscv/bin:${PATH}"

WORKDIR /gcc83
