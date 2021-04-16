# Firesim Image

The BESSPIN image with firesim tools (without building bitstreams).

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/firesim/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s firesim
```