FROM debian:10

# Enable HTTPS support in wget and set nsswitch.conf to make resolution work within containers
RUN apt update \
    && apt install -y ssh openssl ca-certificates  \
    && echo hosts: dns files > /etc/nsswitch.conf \
    # make sure your domain is accepted
    && mkdir -p /root/.ssh/ \
    && touch /root/.ssh/known_hosts \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && apt install -y git software-properties-common wget gnupg vim \
    # General toolchain dependencies
    && apt install -y automake autotools-dev libmpc-dev libmpfr-dev libgmp-dev gawk \
    && apt install -y build-essential gperf patchutils zlib1g-dev libexpat-dev \
    # For riscv-linux build:
    && apt install -y curl openssl bc bison flex make autoconf debootstrap proot \
    && apt install -y libssl-dev debian-ports-archive-keyring device-tree-compiler \
    # Additional reqs
    && apt install -y bsdmainutils texinfo

# Environment
ENV TOOLCHAIN_SRC="/tmp/riscv-gnu-toolchain-gcc83" \
    RISCV="/opt/riscv" \
    RISCV_C_INCLUDE_PATH="/opt/riscv/riscv64-unknown-elf/include" \
    PATH="/opt/riscv/bin:${PATH}"

# Smoke runs
COPY smoke.c .

# Snapshot of master on 2019-08-15 -- Last master commit of riscv-gnu-toolchain prior to bumping riscv-gcc to 9.2
RUN git clone https://github.com/riscv/riscv-gnu-toolchain $TOOLCHAIN_SRC \
    && cd $TOOLCHAIN_SRC \
    && git checkout 0914ab9f41b63681e538ec677c4adeaa889adae5 \
    && git submodule update --init --recursive \
    && ./configure --prefix /opt/riscv --enable-multilib --with-cmodel=medany --host=x86_64 \
    && make linux \
    && make \
    # Test
    && cd - \
    && riscv64-unknown-elf-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null \
    && riscv64-unknown-linux-gnu-gcc -march=rv64imafdc -mabi=lp64d smoke.c -o /dev/null \
    # Cleanup
    && rm -rf $TOOLCHAIN_SRC smoke.c

WORKDIR /gcc83
