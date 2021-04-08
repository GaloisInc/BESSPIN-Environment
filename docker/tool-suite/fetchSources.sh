#! /usr/bin/env bash

set -e

if [ -z $API_KEY ]; then
    echo "API_KEY is unset!"
    exit 1
fi

function pullArtifactory() {
  curl -H 'X-JFrog-Art-Api:'$API_KEY \
    -O "https://artifactory.galois.com/artifactory/$1/$2"
}

for xFile in \
        gfe_ci_id_ed25519.pub  \
        gfe_ci_id_ed25519 ; do
    if [ ! -f $xFile ]; then
        pullArtifactory besspin_generic-nix $xFile
        mv $xFile ${xFile#"gfe_ci_"}
    fi
done