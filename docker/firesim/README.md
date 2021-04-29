# Firesim Image

The BESSPIN image with firesim tools (without building bitstreams).

This image is publicly available at: `galoisinc/besspin:firesim`.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/firesim/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s firesim
```

## Run

The image is expecting a `firesim` checkout, so it shoud be run using the mount flag `-v /path/to/firesim/clone:/firesim`.

For the specific version included, the BESSPIN team used `308ebfe94d7c6ba851ad5a2491289427d74f8ce5` on the [Galois Firesim fork](https://github.com/GaloisInc/BESSPIN-firesim).

Also, firesim requires additional credentials setup for SSH and AWS. Please refer to [the start firesim docker script](https://github.com/GaloisInc/BESSPIN-firesim/start_docker.sh) for all setup required.
