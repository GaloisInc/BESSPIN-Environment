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

RUN git clone git://sourceware.org/git/elfutils.git \
    && cd elfutils \
    && git checkout e8f8dc465a1fa496aa627a330886c0f70f98d4c0 \
    && test -f configure || autoreconf -i -f \
    && ./configure --prefix=${RISCV} --enable-maintainer-mode \
    && make && make install \
    && cd .. \
    && rm -rf elfutils

RUN git clone git://git.code.sf.net/p/libdwarf/code libdwarf \
    && cd libdwarf \
    && git checkout a81397fc41fa171a604235299242edd80f81a7fe \
    && sh scripts/FIX-CONFIGURE-TIMES \
    && ./configure --prefix="${RISCV}" --enable-shared --disable-static CFLAGS="-g -I${RISCV}/include" LDFLAGS="-L${RISCV}/lib" \
    && make && make install \
    && cd .. \
    && rm -rf libdwarf

# Adding files
ADD python2-requirements.txt \
    python3-requirements.txt \
    kernel-devel-3.10.0-957.5.1.el7.x86_64.rpm \
    .

# Python Stuff + kernel-devel + aws-cli
# - Please note that Python2.7 has reached the end of its life, so pip has to be <21.0
#   Also, the centos7 old pip wouldn't be able to install boto3 because of an unsupported 
#   dependency in cryptography
RUN pip install --upgrade "pip < 21.0" \
    && pip install -r python2-requirements.txt \
    && pip3 install -r python3-requirements.txt \
    && yum localinstall -y /kernel-devel-3.10.0-957.5.1.el7.x86_64.rpm \
    && pip install awscli==1.15.76 \
    && rm -rf ~/.cache/pip python*.txt kernel-devel-3.10.0-957.5.1.el7.x86_64.rpm

# environment setup
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_COLLATE=C \
    LC_CTYPE=en_US.UTF-8

RUN echo -e "\
    export FIRESIM_STANDALONE=1\n\
    export FIRESIM_ENV_SOURCED=1\n\
    export RISCV=/riscv-tools-install\n\
    export PATH=/firesim/deploy:/firesim/target-design/chipyard/firemarshal:$RISCV/bin:$PATH\n\n\
    cd /firesim\n\
    if [ -f sourceme-f1-manager.sh ]; then\n\
      source sourceme-f1-manager.sh\n\
    fi"\
    >> /root/.bashrc
