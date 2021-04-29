# Chisel Image

The BESSPIN image with environment for chisel, chipyard, and verilator.

This image is publicly available at: `galoisinc/besspin:chisel`.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/chisel/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s chisel
```