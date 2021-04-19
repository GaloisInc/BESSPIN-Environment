# Get CentOS base image
FROM centos:7.6.1810

# Install necessary packages
RUN yum -y groupinstall "Development Tools" \
    # Replace the just-installed version of git with a more recent version. This is needed for
    # the Chipyard's build.
    && yum -y remove git \
    && yum -y install https://repo.ius.io/ius-release-el7.rpm \
    && yum -y install git222 \
    # Install all other packages.
    && yum -y install \
        "perl(ExtUtils::MakeMaker)" \
        chrpath cmake ctags diffstat dtc \
        expat expat-devel gengetopt gmp-devel gtk3-devel \
        libguestfs-tools libmpc-devel libusb1-devel \
        makeinfo mpfr-devel ncurses-devel patch \
        python36 python36-pip python36-devel python-pip \
        rsync subversion texi2html texinfo wget \
        zlib-devel java-1.8.0-openjdk-devel \
        which sudo epel-release \
    # Install GNU make 4.x (needed to cross-compile glibc 2.28+)
    && yum -y install centos-release-scl \
    && yum -y install devtoolset-8-make \
    # Install python
    && yum install -y python36 python36-pip python36-devel python-pip \
    # Install sbt
    && curl --silent https://bintray.com/sbt/rpm/rpm > /etc/yum.repos.d/bintray-sbt-rpm.repo \
    && yum -y install sbt \
    # Clean up yum artifacts, reduce container size
    && yum clean all

WORKDIR /tmp

# Tools versions
ENV MAKE_VERSION=4.3 \
    VERILATOR_VERSION=v4.034 \
    RISCV=/riscv-tools-install \
    CHIPYARD_VERSION=629a0449d6e18b7ba1ef0541c82873de7b85b909

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

# riscv-toolchain-chipyard
RUN git clone https://github.com/ucb-bar/chipyard.git \
    && cd chipyard \
    && git checkout $CHIPYARD_VERSION \
    && scl enable devtoolset-8 \
        "./scripts/build-toolchains.sh \
        --prefix ${RISCV} \
        riscv-tools" \
    && cp env-riscv-tools.sh ${RISCV}/env.sh \
    && cd .. \
    && rm -rf chipyard

