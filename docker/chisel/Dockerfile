FROM galoisinc/besspin:gfe

# baseline dependencies
RUN apt update \
    && apt install -y wget git curl make unzip emacs-nox gnupg \
    # chipyard dependencies
    && apt install -y build-essential bison flex \
    && apt install -y libgmp-dev libmpfr-dev libmpc-dev zlib1g-dev vim git default-jdk default-jre

# install sbt: https://www.scala-sbt.org/release/docs/Installing-sbt-on-Linux.html
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" \
        | apt-key add \
    && apt update \
    && apt install -y sbt \
    && apt install -y texinfo gengetopt \
    && apt install -y libexpat1-dev libusb-dev libncurses5-dev cmake \
    # deps for poky
    && DEBIAN_FRONTEND=noninteractive apt install -y python3.6 patch diffstat texi2html texinfo subversion chrpath git wget \
    # deps for qemu
    && apt install -y libgtk-3-dev \
    # deps for firemarshal
    && apt install -y python3-pip python3-dev rsync libguestfs-tools expat ctags \
    # install DTC
    && apt install -y device-tree-compiler

# install verilator
RUN git clone http://git.veripool.org/git/verilator \
    && cd verilator \
    && git checkout v4.028 \
    && autoconf \
    && ./configure \
    && make -j "$(nproc)" \
    && make install \
    && cd .. \
    && rm -rf verilator

RUN sbt -version
