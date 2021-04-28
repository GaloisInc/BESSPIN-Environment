# BESSPIN System Builder

The `build.py` script accepts *feature model configurations* and uses them
to build configured processors or OS images.
It is a lightweight wrapper around a few different build processes.
It can build:
- synthesizable System Verilog RTL from GFE-compatible processor sources:
  - Piccolo (BSV)
  - Flute (BSV)
  - ~~Toooba (BSV)~~ **TODO**
  - ~~Rocket (Chisel)~~ **TODO next!** (adapt [rocket-chip-check-config](https://github.com/GaloisInc/BESSPIN-arch-extract/tree/master/rocket-chip-check-config))
  - ~~BOOM (Chisel)~~ **TODO**
- ~~a Verilator simulator executable from any of those RTL sources~~ **TODO soon!** (use GFE scripts)
- ~~a Vivado bitstream for the VCU118 FGPGA from those RTL source~~ **TODO soon!** (use GFE scripts)
- ~~a FreeRTOS image for FPGA-hosted P1-class processors~~ **TODO**
- ~~a Debian Linux image for FPGA-hosted P2-class processors~~ **TODO**
- ~~a Busybox-based Linux image for FPGA-hosted P2-class processors~~ **TODO**

A feature model configuration is represented by a text file where
- the first line is the name of the build process
- subsequent lines represent individual features, as interpreted by that process
- empty lines and `#`-prefixed comment lines are ignored

This configuration format is intended to be simple and flexible enough
to represent all configurable features of the target processes listed above.

Example configuration files for standard GFE systems are provided.
