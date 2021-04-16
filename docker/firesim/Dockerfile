# Get CentOS base image
FROM centos:7.6.1810

# Install necessary packages
RUN yum -y groupinstall "Development Tools" \
    && yum -y install \
        dtc \
        java-1.8.0-openjdk-devel \
        which \
        docker \
        sudo \
        zlib-devel gmp-devel mpfr-devel libmpc-devel \
        epel-release \
    && yum install -y python36 python36-pip python36-devel python-pip \
    # Install sbt
    && curl --silent https://bintray.com/sbt/rpm/rpm > /etc/yum.repos.d/bintray-sbt-rpm.repo \
    && yum -y install sbt \
    # Clean up yum artifacts, reduce container size
    && yum clean all

WORKDIR /tmp

# Tools versions
ENV MAKE_VERSION=4.3 \
    VERILATOR_VERSION=v4.034

# Install more recent make (CentOS 7 has v3.82) for better Chipyard build-dependency-tracking
RUN curl -sSLO https://ftp.gnu.org/gnu/make/make-$MAKE_VERSION.tar.gz \
    && tar xf make-$MAKE_VERSION.tar.gz \
    && cd make-$MAKE_VERSION \
    && ./configure --prefix=/usr/local \
    && make -j $(nproc) \
    && make install \
    && cd .. \
    && rm -rf make-$MAKE_VERSION.tar.gz make-$MAKE_VERSION

# Install Verilator
RUN git clone http://git.veripool.org/git/verilator \
    && cd verilator \
    && git checkout "$VERILATOR_VERSION" \
    && autoconf \
    && ./configure \
    && make -j "$(nproc)" \
    && make install \
    && cd .. \
    && rm -rf verilator

# AWS-FPGA
RUN git clone --depth 1 https://github.com/aws/aws-fpga.git \
    && cd aws-fpga \
    && bash -c 'source sdk_setup.sh' \
    && cd .. \
    && rm -rf aws-fpga

# Here's the riscv-toolchain-chipyard part 

