# The BESSPIN Tool Suite

This software will allow a user to configure SSITH processors
and measure their security features.
It is *prototype alpha software*, complete with bugs and missing features.
Support is provided for SSITH TA1 teams;
your feedback is valuable and will help shape ongoing development.
If you encounter trouble or would like to suggest improvements,
please file an issue here or on the specific tool's GitLab project,
visit the [SSITH Mattermost]( https://mattermost.galois.com/darpassith/)
chat service, or contact ssith_ta1_support@galois.com.

The diagram below illustrates the various components and their relationships.
The boxes indicate formats of static artifacts,
and arrows indicate functionality.
Dashed lines show capabilities that are not yet present in a working state.

![Tool suite workflow](workflow.png "Workflow")

Starting with high-level Chisel or Bluespec System Verilog HDL source files
or the Verilog RTL to which they compile,
feature model extraction generates a Clafer model
summarizing the relevant features of a processor
and the constraints that exist between these features.
(Galois' development version of
Clafer is the current prototype of the LANDO specification language.)
The extracted Clafer model may be fully or partially unconfigured,
and can be incrementally configured using command line tools
or a web-based GUI.
A fully configured Clafer model can then be used to specify
build options for the HDL project,
as well as compiler toolchains, test generation parameters,
and other configurable aspects of the project environment.
Although most of this functionality is not yet implemented,
it will leverage the Nix package manager and build system
to ensure that system configurations are both reproducible and
completely determined by the model's specification.
These specifications together with all system measurements
including power, performance, area, and various forms of test results,
will be stored in a database for later retrieval and aggregate analysis.

The configured HDL source can then be compiled into synthesizable Verilog RTL.
Architecture extraction summarizes the configured project structure
for visual exploration using the Graphviz toolkit.
The Verilog design can be statically traced for potential information leakage.
It may also be compiled into an executable simulation using Verilator,
which in turn can be measured for differential latency per instruction.
Randomized buffer overflow tests can be generated, compiled, and executed
either in software simulation or
in the [GFE](https://gitlab-ext.galois.com/ssith/gfe) FPGA environment.
The resulting log files can be summarized in a dashboard plot.
As tool suite development proceeds and analysis components become more
automated, the dashboard functionality is planned to include
individual and aggregate views of all stored data,
along with a web-based user interface for initiating and managing
automated analysis jobs across multiple build hosts.

While all components shown in the diagram exist in some form,
at present they are only loosely integrated:
the overall workflow has known gaps and requires manual steps
that will later be automated and combined.
The following section gives brief instructions for installing the
BESSPIN Tool Suite and using the individual tools.
The final section of this document lists each individual tool
and its commands, along with a link to its documentation
and source code.


<<<<<<< HEAD
## Tutorial

### Installation
=======
# Setup
>>>>>>> 7332c65c6390b882869b3a8e606ce4b0de4425ed

The BESSPIN tool suite uses the [Nix package manager](https://nixos.org/nix/download.html).

Once Nix is installed, run `nix-shell` in this repository.  Nix will download
and install the BESSPIN tool suite and its dependencies, and will open a shell
with all the commands available in `$PATH`.
**This may take 2 to 3 hours to complete!**


### Extract feature model

# Tool suite walkthrough

This walkthrough demonstrates all the major functionality of the BESSPIN tool
suite.

The walkthrough uses the Piccolo processor as a running example, and requires a
copy of the Piccolo source code to be available alongside the `tool-suite`
checkout.  The easiest way to set this up is to create a symbolic link:

```sh
ln -s /path/to/gfe/bluespec-processors/P1/Piccolo ../Piccolo
```


## Architecture extraction and visualization

The BESSPIN architecture extraction tool analyzes a hardware design written in
SystemVerilog or BSV (Chisel support coming soon), extracts architectural
information from the design, and visualizes that information in various forms.

To visualize the structure of modules in the Piccolo processor, run these
commands:

```sh
# Generate graphs of modules in the design
besspin-arch-extract tutorial/piccolo.toml visualize
# Convert the graphs to PDF
for f in piccolo-arch/*.dot; do dot -Tpdf $f -o ${f%.dot}.pdf; done
```

These commands generate PDF drawings showing the internal structure of
modules.  For example, the generated `piccolo-arch/**TODO**.pdf` file looks
like this:

![](tutorial/piccolo-example-module.png "Piccolo **TODO** module")

This visualization shows that the **TODO** module contains instances of the
**TODO** and **TODO** modules, along with several registers.


### `besspin-arch-extract` arguments

The `besspin-arch-extract` command takes as arguments a path to a configuration
file (`tutorial/piccolo.toml`) and a subcommand to run (`visualize`).  `dot` is
a standard [Graphviz](https://www.graphviz.org/) command for drawing graphs.

The architecture extraction config file provides information on the hardware
design, such as the paths to the source files that make up the design, and
options that control the visualization algorithm.  See the comments in the
`[src.piccolo]` and `[graphviz]` sections of
[`tutorial/piccolo.toml`](tutorial/piccolo.toml) for more details.

`visualize` is the primary subcommand of `besspin-arch-extract`.  By default,
it generates a graph in Graphviz format for each module of the design, showing
for each one any submodules or state elements it contains and the connections
between them.


### Level of detail

The options in the `[graphviz]` section of the configuration file control the
level of detail of the generated graphs.  For example, these commands use an
alternate configuration file to generate a higher-level view of Piccolo's
modules:

```sh
besspin-arch-extract tutorial/piccolo-high-level.toml visualize
for f in piccolo-arch/*.dot; do dot -Tpdf $f -o ${f%.dot}.pdf; done
```

Now `piccolo-arch/**TODO**.pdf` looks like this:

![](tutorial/piccolo-example-module-high-level.png
    "Piccolo **TODO** module, high-level view")

This visualization shows only the flow of data between logic elements, not the
individual connections between their ports.

A more detailed, lower-level view is also available: run the same commands
again using the `tutorial/piccolo-low-level.toml` config file instead.


### Configure feature model

### Extract architecture

### Build simulators (???)

### Run timing tests

### Run buffer overflow tests


## Components

Within the Nix shell, the following tools are available:

* [Architecture and feature model extraction](https://gitlab-ext.galois.com/ssith/arch-extract):
  - `besspin-arch-extract` **TODO**
  - `besspin-feature-extract` **TODO**
  - [`clafer`](https://gitlab-ext.galois.com/ssith/clafer)

* The graphical [feature model configurator](https://gitlab-ext.galois.com/ssith/feature-model-configurator-ui):
  running the `besspin-configurator` command starts a local web server,
  where you can upload a Clafer file for interactive configuration.

* [Halcyon](https://gitlab-ext.galois.com/ssith/halcyon):
  an information-flow tracing static analysis tool for Verilog source.
  Running `besspin-halcyon <files>` will prompt you for a signal name.
  See the project documentation for usage details.

* RISC-V [timing tests](https://gitlab-ext.galois.com/ssith/riscv-timing-tests):
  - `besspin-timing-test-driver`: Test driver for Rocket and BOOM

  - `besspin-timing-test-latency`: ??? *(this is `scripts/latency-test.go` from
    the `riscv-timing-tests` repo)*

  - `besspin-timing-plot-int`: Plot the time taken on various inputs, using data
    produced by `besspin-timing-test`.

  - `besspin-timing-interpolate`: Estimate the time that would be taken on
    untested inputs, using data produced by `besspin-timing-test`.

  - `besspin-unpack-timing-test-src`: Unpack the source code needed to build
    timing test binaries for new instructions.

* [Bofgen](https://gitlab-ext.galois.com/ssith/testgen):
  Tools for generating, running, and scoring buffer overflow test cases.
  - `besspin-bofgen --help` prints a usage summary
  - `besspin-unpack-bof-test-harness` sets up a test harness 

