# Copyright (c) 2003-2019 Eelco Dolstra and the Nixpkgs/NixOS contributors
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

{ stdenv, fetchurl, dpkg, gawk, perl, wget, coreutils, utillinux
, gnugrep, gnutar, gnused, gzip, gnupg, which, xz, makeWrapper }:
# USAGE like this: debootstrap sid /tmp/target-chroot-directory
# There is also cdebootstrap now. Is that easier to maintain?
let binPath = stdenv.lib.makeBinPath [
    coreutils
    dpkg
    gawk
    gnugrep
    gnupg
    gnused
    gnutar
    gzip
    perl
    wget
    which
    xz
  ];
in stdenv.mkDerivation rec {
  name = "debootstrap-${version}";
  version = "1.0.114";

  src = fetchurl {
    # git clone git://git.debian.org/d-i/debootstrap.git
    # I'd like to use the source. However it's lacking the lanny script ? (still true?)
    url = "mirror://debian/pool/main/d/debootstrap/debootstrap_${version}.tar.gz";
    sha256 = "14lw18bhxap1g15q0rhslacj1bcrl69wrqcx6azmbvd92rl4bqd8";
  };

  nativeBuildInputs = [ makeWrapper ];

  patches = [
    ./debootstrap-shell-check.patch
    ./debootstrap-absolute-paths.patch
    ./debootstrap-second-stage-permissions.patch
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    substituteInPlace debootstrap \
      --replace '#!/bin/sh' '#!/usr/bin/env bash' \
      --subst-var-by VERSION ${version}

    d=$out/share/debootstrap
    mkdir -p $out/{share/debootstrap,bin}

    mv debootstrap $out/bin

    cp -r . $d

    wrapProgram $out/bin/debootstrap \
      --prefix PATH : ${binPath} \
      --set-default DEBOOTSTRAP_DIR $d

    mkdir -p $out/man/man8
    mv debootstrap.8 $out/man/man8

    rm -rf $d/debian

    runHook postInstall
  '';

  meta = {
    description = "Tool to create a Debian system in a chroot";
    homepage = https://wiki.debian.org/Debootstrap;
    license = stdenv.lib.licenses.mit;
    maintainers = [ stdenv.lib.maintainers.marcweber ];
    platforms = stdenv.lib.platforms.linux;
  };
}
