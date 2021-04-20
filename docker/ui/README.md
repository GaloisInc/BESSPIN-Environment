# Tool-Suite UI Image

The image is built on top of the [BESSPIN Tool-Suite Image](../tool-suite/README.md).

See [BESSPIN-UI](https://github.com/GaloisInc/BESSPIN-UI) for more details.

## Run

In order to use the container, please follow the instructions in [BESSPIN-UI](https://github.com/GaloisInc/BESSPIN-UI). A Yaml compose file is needed for a proper setup of the entrypoint.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/besspin-ui/Dockerfile-ui).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s ui
```
