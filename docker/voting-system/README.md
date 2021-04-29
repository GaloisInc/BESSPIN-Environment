# Voting-System Image

This docker image contains all of the tools necessary to develop, evolve, maintain,
validate, and verify the BESSPIN "Smart Ballot Box" (SBB) SSITH system
demonstration, shown at DEF CON 2019.

Included in this image, which is based upon the baseline BESSPIN GFE
docker image, are specification and reasoning tools like Cryptol, SAW,
and Frama-C, automatic theorem provers like Z3, the Coq interactive
logical framework, and all of the underlying tools and frameworks
necessary to use these applied formal methods technologies.  Also
included is the gcc AVR cross-compiler for experiments in porting the
SBB to AVR-based microcontroller like Arduinos.

This image is publicly available at: `galoisinc/besspin:voting-system`.

## Build

The Dockerfile was initially copied from [this internal repo](https://gitlab-ext.galois.com/ssith/docker-tools/-/blob/develop/voting_system/Dockerfile).

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s voting-system
```
