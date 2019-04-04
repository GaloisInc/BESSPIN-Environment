# The BESSPIN Tool Suite

TODO: Release documentation goes here.


![Tool suite workflow](workflow.png "Workflow")*Tool suite data paths.*

## Setup

The BESSPIN tool suite uses the [Nix package manager](https://nixos.org/nix/download.html).

Once Nix is installed, run `nix-shell` in this repository.  Nix will download
and install the BESSPIN tool suite and its dependencies, and will open a shell
with all the BESSPIN tools available in `$PATH`.

The available commands are:  *[TODO: turn these into links to relevant
documentation/tutorial sections]*

 * `besspin-configurator`: The BESSPIN feature model configurator.

 * `besspin-halcyon`: An information-leakage analysis tool.

 * `besspin-bofgen`: A tool for generating buffer overflow test cases.

 * `besspin-unpack-bof-test-harness`: Sets up a test harness for running buffer
   overflow tests.

### Components:

- https://gitlab-ext.galois.com/ssith/feature-model-configurator-ui
- https://gitlab-ext.galois.com/ssith/arch-extract
- https://gitlab-ext.galois.com/ssith/clafer
- https://gitlab-ext.galois.com/ssith/claferIG
- https://gitlab-ext.galois.com/ssith/riscv-timing-tests
- https://gitlab-ext.galois.com/ssith/halcyon
- https://gitlab-ext.galois.com/ssith/testgen


TODO: submodule tagged release versions
