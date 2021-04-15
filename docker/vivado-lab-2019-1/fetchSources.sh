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
        install_config_vivado.txt  \
        Xilinx_Vivado_Lab_Lin_2019.1_0524_1430.tar.gz \
        install_config_hw.txt \
        Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz ; do
    if [ ! -f $xFile ]; then
        pullArtifactory galwegians_generic-local $xFile
    fi
done
