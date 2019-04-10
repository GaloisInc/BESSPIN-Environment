{ stdenv, toolchain, oldName, newName }:

# This package builds a copy of `toolchain`, but changes the prefix of files in
# `${toolchain}/bin` from `oldName` to `newName`.  We don't rename all files
# containing `oldName` because the binaries in `bin/` contain hardcoded paths
# such as `../$[oldName}/bin/ld`.

stdenv.mkDerivation rec {
  name = toolchain.name;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir $out
    cp -r ${toolchain}/* $out

    cd $out/bin
    chmod u+w .
    for f in ${oldName}-*; do
      mv -v $f ${newName}''${f#${oldName}}
    done
  '';
}
