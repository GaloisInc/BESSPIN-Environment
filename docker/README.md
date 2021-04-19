# Dockerfiles for BESSPIN Tool-Suite

This document outlines the infrastructure provided to cross-build applications/programs for
some of the SSITH targets, in addition to run the tool-suite on various environments. 

The [Docker.md](./Docker.md) document has an introduction for Docker beginners with an example of how to use the GFE docker image to debug a VCU118 target.

The following containers are provided:

- [BESSPIN GFE image](./gfe/README.md): It contains most of the core development tools necessary for
interacting with SSITH GFE work.

- [BESSPIN Tool-Suite image](./tool-suite/README.md): The GFE image in addition to nix-shell installed and the nix store populated to the last released version of BESSPIN.

- [Chisel image](./chisel/README.md): Necessary environment for chisel development.

- [Firesim image](./firesim/README.md): Necessary environment for firesim development.

- [Voting system image](./voting-system/README.md): Contains all of the tools necessary to develop, evolve, maintain,
validate, and verify the BESSPIN "Smart Ballot Box" (SBB) SSITH system
demonstration, shown at DEF CON 2019.

- [GCC 8.3](./gcc83/README.md): This image provides riscv64 GCC v8.3.

- [Vivado Lab 2019.1](./vivado-lab-2019-1/README.md): Xilinx Vivado Lab 2019.1 on top of either the GFE image or the Tool-Suite image. This image is not public, and cannot be built without providing Xilinx proprietary resources. For Galois partners, if you are authorized to use the Galois Xilinx linceses, you may thus use the artifactory API keys to download either the container or the needed resources.

- [Vivado SDK 2019.1](./vivado-sdk-2019-1/README.md): Xilinx Vivado SDK 2019.1 on top of the GFE image; this is used to build bitstreams. This image is not public, and cannot be built without providing Xilinx properitary resource in addition to the Xilinx license. For Galois partners, if you are authorized to use the Galois Xilinx linceses, you may thus use the artifactory API keys to download either the container or the needed resources.

- [Cheri Toolchains](./fett-cheri/README.md): The toolchains from SRI International and University of Cambridge related to the Cheri processors for the FETT bug bounty.

- [Morpheus Toolchains](./michigan/README.md): The toolchains from University of Michigan related to the Morpheus processor.

## OPEN-SOURCE

This part should be removed from the readme when open-sourcing along with switching to `https` instead of `git@github` and removing `--ssh default` form the docker build arguments.


## Build Usage

```
usage: build-docker.py [-h] [-b] [-p] [-r] [-n]
                       [-a | -s [SELECTIMAGES [SELECTIMAGES ...]]]
                       [-v IMAGEVARIANTS]

Build one or all docker images in this directory

optional arguments:
  -h, --help            show this help message and exit
  -b, --build           Build the specified containers.
  -p, --push            Push the specified containers.
  -r, --fetchResources  Fetch the resources for the specified containers.
                        (implied with -b)
  -n, --publicOnly      No credentials for private containers.
  -a, --all             All possible (see -n) images.
  -s [SELECTIMAGES [SELECTIMAGES ...]], --selectImages [SELECTIMAGES [SELECTIMAGES ...]]
                        Select the following image(s).
```

## Example Run

1. Acquire the docker image,
    ```
    docker pull galoisinc/besspin:gfe
    ```

2. Run the docker image, mounting the directory of the project to be compiled,
    ```
   docker run --rm -it -v /path/to/project:/projectname -w /projectname galoisinc/besspin:gfe
   ```
   
3. Build the project. For example, if the file to be compiled is the simple C file,
    
    **hello_world.c**   
    ```c
    #include <stdio.h>
    
    int main()
    {
        puts("Hello world!\n");
        return 0;
    }
    ```
   
    then the command,
   
    ```
    riscv64-unknown-linux-gnu-gcc -o hello_world hello_world.c
    ```
   
    would build `hello_world` for the host triple `riscv64-unknown-linux-gnu`.

4. Exit the docker shell and secure copy the build to the target instance,

    ```
    scp <programname> <username>@<INSTANCE.IP.ADDRESS>
    ```

5. On the instance, run the executable,

    ```
    ./programname
    ```
