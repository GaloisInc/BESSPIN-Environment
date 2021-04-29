# GCC 8.3 Image

The [BESSPIN GFE Image](../gfe/README.md) has most of the core development tools necessary for interacting with SSITH projects and repositories. One of those tools is the riscv64 GCC v9.2. This image provides riscv64 GCC v8.3.

This image is publicly available at: `galoisinc/besspin:gcc83`.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/gfe/Dockerfile).

This build takes hours.

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s gcc83
```

### Manually

To build the image:
```bash
docker build --tag galoisinc/besspin:gcc83 .
```

To publish it:
```bash
docker push galoisinc/besspin:gcc83
```
