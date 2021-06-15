# Use latest Ubuntu as a base
FROM ubuntu:20.04

# Updates and dependencies
RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=USA/Pacific
RUN apt-get upgrade -y
RUN apt-get install -y autoconf automake libtool pkg-config clang bison cmake ninja-build samba flex texinfo libglib2.0-dev libpixman-1-dev libarchive-dev libarchive-tools libbz2-dev libattr1-dev libcap-ng-dev wget git vim
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN useradd -ms /bin/bash besspinuser

# Set up for cloning
RUN mkdir -p /opt/cheribuild
RUN chown besspinuser /opt/cheribuild
USER besspinuser
RUN git clone https://github.com/CTSRD-CHERI/cheribuild.git /opt/cheribuild -b hmka2
WORKDIR /opt/cheribuild

# Checkout SDK
RUN mkdir -p /home/besspinuser/cheri/llvm-project
RUN git clone https://github.com/CTSRD-CHERI/llvm-project /home/besspinuser/cheri/llvm-project -b cherifreertos-gprel-dev

# Build SDK
RUN ./cheribuild.py llvm --skip-update
RUN ./cheribuild.py newlib-baremetal-riscv64-purecap
RUN ./cheribuild.py compiler-rt-builtins-baremetal-riscv64-purecap

# Checkout FreeRTOS
RUN git clone -b hmka2 https://github.com/CTSRD-CHERI/FreeRTOS /home/besspinuser/cheri/freertos --recurse-submodules
RUN cd /home/besspinuser/cheri/freertos/FreeRTOS/Demo/RISC-V_Galois_demo && git checkout cheridemo && git pull && cd -
# THIS LINE when iic-init branch is merged into master
#RUN cd /home/besspinuser/cheri/freertos/FreeRTOS/Demo/RISC-V-Generic/ && git checkout master && git pull && cd -
# THESE LINES for now
RUN cd /home/besspinuser/cheri/freertos/FreeRTOS/Demo/RISC-V-Generic/ &&\
    git remote add galois https://github.com/GaloisInc/FreeRTOS-Demos-CHERI-RISC-V.git &&\
    git fetch galois && git checkout iic-init && cd -
RUN cd /home/besspinuser/cheri/freertos/FreeRTOS/Demo/RISC-V-Generic/ && git checkout master && git pull && cd -

# Build FreeRTOS
# This is executed to pre-fetch all FreeRTOS dependencies and build a binary that
# is used as Target3 in Cyberphys Demonstrator
# See README.md for mode details about the configuration
RUN ./cheribuild.py freertos-baremetal-riscv64-purecap --freertos/prog cyberphys \
    --freertos/toolchain llvm  --freertos/platform gfe-p2 --freertos/compartmentalize \
    --skip-update --freertos/ipaddr 10.88.88.32/24 --freertos/gateway 10.88.88.1/24 -j 1
