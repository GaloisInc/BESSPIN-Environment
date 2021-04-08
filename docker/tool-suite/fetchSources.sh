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
        galoisCredentialsNetrc.txt ; do
    if [ ! -f $xFile ]; then
        pullArtifactory besspin_generic-nix $xFile
    fi
done
