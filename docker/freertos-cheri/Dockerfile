# Use latest Ubuntu as a base
FROM ubuntu:20.04

# Updates and dependencies
RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=USA/Pacific
RUN apt-get upgrade -y
RUN apt-get install -y autoconf automake libtool pkg-config clang bison cmake ninja-build samba flex texinfo libglib2.0-dev libpixman-1-dev libarchive-dev libarchive-tools libbz2-dev libattr1-dev libcap-ng-dev wget git
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN useradd -ms /bin/bash galoisuser

# Set up for cloning
RUN mkdir -p /opt/cheribuild
RUN chown galoisuser /opt/cheribuild
USER galoisuser
RUN git clone https://github.com/CTSRD-CHERI/cheribuild.git /opt/cheribuild
WORKDIR /opt/cheribuild

# Checkout
RUN git checkout hmka2
# Trick for getting the right llvm version
RUN mkdir -p /home/galoisuser/cheri/llvm-project
RUN git clone https://github.com/CTSRD-CHERI/llvm-project /home/galoisuser/cheri/llvm-project
WORKDIR /home/galoisuser/cheri/llvm-project
RUN git checkout cherifreertos-gprel-dev
WORKDIR /opt/cheribuild

# Build SDK
RUN ./cheribuild.py llvm
RUN ./cheribuild.py newlib-baremetal-riscv64-purecap
RUN ./cheribuild.py compiler-rt-builtins-baremetal-riscv64-purecap

# Build FreeRTOS
# This is executed so all FreeRTOS dependencies are fetched
RUN ./cheribuild.py freertos-baremetal-riscv64-purecap --freertos/prog cyberphys --freertos/toolchain llvm  --freertos/platform gfe-p2 --freertos/compartmentalize --freertos/ipaddr 10.88.88.2/24 --freertos/gateway 10.88.88.1/24 -j 1 -v
# The file is in /home/galoisuser/cheri/build/freertos-baremetal-riscv64-purecap-build/RISC-V-Generic_cyberphys.elf
