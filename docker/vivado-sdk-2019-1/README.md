# BESSSPIN + Vivado Sdk Image

This image is based on the GFE image in addition to Xilinx Vivado SDK 2019.1. This is mostly for internal and CI use, but we are including it since they might be useful.

The image is mainly used for building bitstreams for VCU118.

The image is available to Galois partners at: `artifactory.galois.com:5008/vivado-sdk-2019-1`.

## Build 

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/gfe_ci/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    API_KEY=<YOURKEY> ./build-docker.py -bp -s vivado-sdk-2019-1
```