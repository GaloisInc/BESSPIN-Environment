# Dockerfiles for BESSPIN Tool-Suite

This document outlines the infrastructure provided to cross-build applications/programs for
some of the SSITH targets, in addition to run the tool-suite on various environments. The following containers are provided:

- [BESSPIN GFE image](./gfe/README.md): It contains most of the core development tools necessary for
interacting with SSITH GFE work.

- [Cheri Toolchains](./cheri/README.md): The toolchains from SRI International and University of Cambridge related to the Cheri processors. 

- [Morpheus Toolchains](./michigan/README.md): The toolchains from University of Michigan related to the Morpheus processor.

## Example Usage

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
