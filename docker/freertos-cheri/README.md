# SRI-Cambridge toolchain docker image #

The image is publicly available at: `galoisinc/besspin:freertos-cheri`.

## CHERI FreeRTOS Toolchain

The purpose of this image is to build the CHERI-FreeRTOS demonstator image. Note that the only configurable option is the target IP and the target gateway. If you need to do further modificatons, updating the CHERI-FreeRTOS copy is necessary.

To compile the image for the demonstrator, execute:
```
docker run -v $PWD:/workdir -w /opt/cheribuild galoisinc/besspin:freertos-cheri bash -c "./cheribuild.py freertos-baremetal-riscv64-purecap --freertos/prog cyberphys --freertos/toolchain llvm  --freertos/platform gfe-p2 --freertos/compartmentalize --freertos/ipaddr 10.88.88.32/24 --freertos/gateway 10.88.88.1/24 -j 1 -v; cp /home/besspinuser/cheri/build/freertos-baremetal-riscv64-purecap-build/RISC-V-Generic_cyberphys.elf /workdir/FreeRTOS.elf"
```

And modify the IP addr/gateway as necessary.

## Instructions to create the image

### Using build-docker.py

You can build (`-b`) and push (`-p`):
```bash
    ./build-docker.py -bp -s freertos-cheri
```
