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

# Additional reqs
RUN apt-get install -y bsdmainutils texinfo

# Build the toolchain
ENV $TOOLCHAIN_SRC="/tmp/riscv-gnu-toolchain-gcc83"
RUN git clone https://github.com/riscv/riscv-gnu-toolchain $TOOLCHAIN_SRC \
        && cd $TOOLCHAIN_SRC \
        && git checkout 0914ab9f41b63681e538ec677c4adeaa889adae5 \
        && git submodule update --init --recursive

RUN cd $TOOLCHAIN_SRC \
        && ./configure --prefix /opt/riscv --enable-multilib --with-cmodel=medany --host=x86_64 \
        && make linux
        && make

# Cleanup
RUN rm -rf $TOOLCHAIN_SRC

# RISC-V toolchains (both linux and newlib versions):
# Set PATH for RISCV-tools
ENV RISCV="/opt/riscv"
ENV RISCV_C_INCLUDE_PATH="/opt/riscv/riscv64-unknown-elf/include"
ENV PATH="/opt/riscv/bin:${PATH}"

# Smoke runs
COPY smoke.c .
RUN riscv64-unknown-elf-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null
RUN riscv64-unknown-linux-gnu-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null
RUN rm smoke.c

WORKDIR /gcc83
