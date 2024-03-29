# Tool-Suite Image

This image is built on top of the [BESSPIN GFE Image](../gfe/README.md) which contains most of the core development tools necessary for interacting with SSITH projects and repositories.

This image is publicly available at: `galoisinc/besspin:tool-suite`.

## Contents

It has [Nix package manager](https://nixos.org/) installed, in addition to the nix store populated for the version of Tool-Suite that was used at the time of creating this image and pushing it.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/fett_target/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    API_KEY=<YOURKEY> ./build-docker.py -bp -s tool-suite
```

### Manually

To download from the binary cache (private to Galois partners), you need to provide the file:
- galoisCredentialsNetrc.txt   

This file can be fetched using:
```bash
    API_KEY=<YOURKEY> ./build-docker.py -r -s tool-suite
```

Then, based on you need to to use the private binary cache, select the needed flags and run:
```bash
DOCKER_BUILDKIT=1 docker build \
    --progress=plain \
    --secret id=galoisCredentialsNetrc,src=./galoisCredentialsNetrc.txt \
    --network=host \
    --tag galoisinc/besspin:tool-suite \
    .
```

To publish it:
```bash
docker push galoisinc/besspin:tool-suite
```
