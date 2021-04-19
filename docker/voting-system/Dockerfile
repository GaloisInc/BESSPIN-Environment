# Reuse BESSPIN base GFE image.
FROM galoisinc/besspin:gfe

# Install needed packages
RUN apt update \
    && apt install -y wget git curl make lsb-release \
    && apt install -y autoconf libgmp3-dev m4 software-properties-common \
    # Additional tools
    && apt install -y bash-completion emacs xxd clang-format clang-tidy \
    # AVR cross-compilation
    && apt install -y gcc-avr binutils-avr avr-libc

# Install Cryptol
RUN apt install libtinfo5 \
    && wget https://github.com/GaloisInc/cryptol/releases/download/2.9.0/cryptol-2.9.0-Linux-x86_64.tar.gz \
    && tar xzf cryptol-2.9.0-Linux-x86_64.tar.gz \
    && cp -r cryptol-2.9.0-Linux-x86_64/bin/* /usr/local/bin/ \
    && cp -r cryptol-2.9.0-Linux-x86_64/share/* /usr/local/share \
    && rm -rf cryptol-2.9.0-Linux-x86_64.tar.gz cryptol-2.9.0-Linux-x86_64

# Install Z3 solver
RUN apt install -y unzip \
    && wget https://github.com/Z3Prover/z3/releases/download/z3-4.8.8/z3-4.8.8-x64-ubuntu-16.04.zip \
    && unzip z3-4.8.8-x64-ubuntu-16.04.zip \
    && cp -r z3-4.8.8-x64-ubuntu-16.04/bin/* /usr/local/bin/ \
    && cp -r z3-4.8.8-x64-ubuntu-16.04/include/* /usr/local/include/ \
    && rm -rf z3-4.8.8-x64-ubuntu-16.04.zip z3-4.8.8-x64-ubuntu-16.04

# Install SAW
RUN wget https://github.com/GaloisInc/saw-script/releases/download/v0.5/saw-0.5-Ubuntu14.04-64.tar.gz \
    && tar xf saw-0.5-Ubuntu14.04-64.tar.gz \
    && cp -r saw-0.5-Ubuntu14.04-64/bin/saw /usr/local/bin/ \
    && cp -r saw-0.5-Ubuntu14.04-64/bin/cryptol /usr/local/bin/cryptol-2.8.1 \
    && cp -r saw-0.5-Ubuntu14.04-64/lib/* /usr/local/lib/ \
    && mkdir /usr/local/saw-0.5 \
    && cp -r saw-0.5-Ubuntu14.04-64/doc /usr/local/saw-0.5/ \
    && cp -r saw-0.5-Ubuntu14.04-64/examples /usr/local/saw-0.5/ \
    && rm -rf saw-0.5-Ubuntu14.04-64.tar.gz saw-0.5-Ubuntu14.04-64

#  Opam
RUN apt install -y opam \
    && apt install -y zlib1g-dev libgmp-dev libgtksourceview2.0-dev libgnomecanvas2-dev autoconf \
    && apt install -y graphviz \
    && opam init -y --disable-sandboxing --auto-setup \
    && opam update \
    && opam switch create 4.10.0 \
    && opam install -y depext \
    && opam depext -y zarith lablgtk conf-gtksourceview conf-gnomecanvas \
    && opam install -y zarith lablgtk conf-gtksourceview conf-gnomecanvas \
    && opam install -y yojson \
    && opam switch default \
    && opam install -y why3 \
    && opam install -y coq \
    && opam config env \
    # Frama-C install
    && opam switch 4.10.0 \
    && opam depext frama-c \
    && opam install -y --deps-only frama-c \
    && opam install -y frama-c

# Environment setup
ENV PATH="/root/.opam/default/bin:${PATH}"

# Set the working directory
WORKDIR /voting-system
