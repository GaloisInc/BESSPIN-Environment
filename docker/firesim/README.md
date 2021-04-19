# Firesim Image

The BESSPIN image with firesim tools (without building bitstreams).

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/firesim/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s firesim
```

## Run

The image is expecting a `firesim` checkout. So please run it using the flag `-v /path/to/firesim/clone:/firesim`.

For the specific version included, the BESSPIN team used `e8d7cac314cca70a8923333c599805514973c733` on the [Galois Firesim fork](https://github.com/GaloisInc/BESSPIN-firesim).
