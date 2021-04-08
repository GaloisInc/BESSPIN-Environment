# Tool-Suite Image

This image is built on top of the [BESSPIN GFE Image](../gfe/README.md) which contains most of the core development tools necessary for interacting with SSITH projects and repositories.

## Contents

It has [Nix package manager](https://nixos.org/) installed, in addition to the nix store populated for the version of Tool-Suite that was used at the time of creating this image and pushing it.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/fett_target/Dockerfile).


**OPEN-SOURCE**: The dockerfile and this part should be edited prior to open-sourcing. So you have to forward your ssh key to clone the repos (this is done using buildkit). Also, the following needs to be done before deleting this paragraph and open-sourcing:
- Update the binary cache setup from using artifactory.
- The binarcy cache sanity check command should be updated accordingly.
- FETT-Target and links should be updated to match Galois's.
- The image should be pushed to the `<NEWPLACE>/besspin:tool-suite`.

For Internal Use:   
    If you have access to Galois artifactory, you can benefit from the private binary cache:
    ```
        API_KEY=<YOURKEY> ./fetchSources.sh
    ```

Then, based on whether you need to forward your ssh keys for the build, or whether you need to to use the private binary cache, select the needed flags and run:
```bash
DOCKER_BUILDKIT=1 docker build \
    --progress=plain \
    --ssh default \
    --secret id=galoisCredentialsNetrc,src=./galoisCredentialsNetrc.txt \
    --network=host \
    --tag artifactory.galois.com:5008/besspin:tool-suite \
    .
```

To publish it:
```bash
docker push artifactory.galois.com:5008/besspin:tool-suite
```
