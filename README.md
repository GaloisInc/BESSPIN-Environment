# The BESSPIN Tool Suite

This software will allow a user to configure SSITH processors
and measure their security features.
It is *prototype alpha software*, complete with bugs and missing features.
Support is provided for SSITH TA1 teams;
your feedback is valuable and will help shape ongoing development.
If you encounter trouble or would like to suggest improvements,
please file an issue here or on the specific tool's GitLab project,
visit the [SSITH Mattermost](https://mattermost.galois.com/darpassith/)
chat service, or contact ssith_ta1_support@galois.com.

Contents:
1. [Overview](#overview) of tool suite workflow
2. [Tutorial](#tutorial) example walkthrough
3. [Components](#components) listed and linked


## Overview

The diagram below illustrates the various tool suite components
and the relationships among them.
Boxes indicate formats of static artifacts
and arrows indicate functionality.
Dashed lines show capabilities that are planned for future releases
but are not yet working.

![Tool suite workflow](workflow.png "Workflow")

Starting with high-level Chisel or Bluespec SystemVerilog HDL source files,
or the Verilog RTL to which they compile,
feature model extraction generates a Clafer model
summarizing the relevant features of a processor
and the constraints among these features
(Galois's development version of
Clafer is the current prototype of the LANDO specification language).
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
These specifications, together with all system measurements
including power, performance, area, and various forms of test results,
will be stored in a database for later retrieval and aggregate analysis.

The configured HDL source can then be compiled into synthesizable Verilog RTL.
Architecture extraction summarizes the configured project structure
for visual exploration using the Graphviz toolkit.
The Verilog design can be statically traced for potential information leakage.
It may also be compiled into an executable simulation using Verilator,
which in turn can be measured for differential latency per instruction.
The design can be tested for performance using standard benchmark suites.
Randomized buffer overflow tests can be generated, compiled, and executed
either in software simulation or
in the [GFE](https://gitlab-ext.galois.com/ssith/gfe) FPGA environment.
The resulting log files can be summarized in a dashboard plot.
As tool suite development proceeds and analysis components become more
automated, dashboard functionality is planned to include
individual and aggregate views of all stored data,
along with a web-based user interface for initiating and managing
automated analysis jobs across multiple build hosts.

While all components shown in the diagram exist in some form,
at present they are only loosely integrated;
the overall workflow has known gaps and requires manual steps
that will later be automated and combined.
In particular, **the timing tests do not currently have a reproducible demo**,
and thus are omitted from the tutorial.
This will be addressed in an upcoming release.
The final section of this document lists each individual tool
and its commands, along with a link to its documentation
and source code.


## Tutorial

This section is a walkthrough
demonstrating the main functionality of the BESSPIN tool suite.
More complete documentation is available for each of the [component projects](#components)
linked to in the following section.

All sections of this tutorial (with the exception of "Setup") are independent
and can be performed in any order.  In cases where one section depends on the
output of a previous section, a pregenerated copy of the output file is
included in the [`tutorial`](tutorial) subdirectory so that the later step can
be completed even if the first one fails or is skipped.


### Setup

While not all of the component tools require an FPGA environment,
we assume that the tool suite is installed on a [GFE host](https://gitlab-ext.galois.com/ssith/gfe)
and has access to Vivado as well as the Bluespec compiler.

The Tool Suite requires the [Nix package manager](https://nixos.org/nix/).  To
install it, follow [these instructions](https://nixos.org/nix/manual/#sect-multi-user-installation).

Once Nix is installed, run `nix-shell` with this repository as your current
working directory.  Nix will download
and install the BESSPIN Tool Suite and its dependencies, and will open a shell
with all the commands available in `$PATH`.
The first run of nix-shell must download dependencies and build parts of the
tool suite from source, which takes 1-2 hours.
<!-- Measured time: 1h15 on a VM with a fresh install of Debian and Nix -->
Subsequent runs will use locally cached packages,
and should start up within seconds.

All commands in the rest of the tutorial should be run inside the `nix-shell`
session.


The remainder of this tutorial uses the Piccolo processor as a running example,
and requires a copy of the Piccolo source code to be available alongside the
`tool-suite` directory.  The easiest way to set this up is to create a symbolic
link:

```sh
ln -s /path/to/gfe/bluespec-processors/P1/Piccolo ../Piccolo
```


### Architecture extraction and visualization

The BESSPIN architecture extraction tool analyzes a hardware design written in
SystemVerilog or BSV (with Chisel support coming soon), extracts architectural
information from the design, and visualizes that information in various forms.

To visualize the structure of modules in the Piccolo processor, run these
commands:

```sh
# Generate graphs of modules in the design
besspin-arch-extract tutorial/piccolo.toml visualize
# Convert the graphs to PDF
for f in piccolo-arch/*.dot; do dot -Tpdf $f -o ${f%.dot}.pdf; done
```

The second command may print several lines of harmless "Fontconfig errors", but
it will still render PDFs successfully.  Afterward, the `piccolo-arch`
directory will contain PDF drawings showing the internal structure of some
Piccolo modules.  For example, the generated
`piccolo-arch/Shifter_Box.mkShifter_Box.pdf` file looks like this:

![](tutorial/piccolo-example-module.png "Piccolo mkShifter_Box module")

This visualization shows that the `mkShifter_Box` module contains several
registers and shows some of the connections between them; some connections
are currently omitted due to limitations of the architecture extraction tool,
which will be corrected in future releases.

The options in the [`tutorial/piccolo.toml`](tutorial/piccolo.toml)
configuration file control the level of detail of the generated graphs.  By
using a configuration file with different settings, you can generate a
lower-level view of Piccolo's modules:

```sh
besspin-arch-extract tutorial/piccolo-low-level.toml visualize
for f in piccolo-arch/*.dot; do dot -Tpdf $f -o ${f%.dot}.pdf; done
```

Now `piccolo-arch/Shifter_Box.mkShifter_Box.pdf` looks like this:

![](tutorial/piccolo-example-module-low-level.png
    "Piccolo mkShifter_Box module, low-level view")

The visualization now shows the details of nets and combinational logic
elements connected between the various registers.

A less detailed, higher-level view is also available: run the same commands
again using the `tutorial/piccolo-high-level.toml` config file instead.

For more details on `besspin-arch-extract` configuration and subcommands, see
[the full README](https://gitlab-ext.galois.com/ssith/arch-extract/#driver-besspin-arch-extract).


### Feature model extraction

The BESSPIN feature model extraction tool tests a variety of configurations of
a design and generates a machine-readable feature model that describes the
configurable features of the design, the dependencies among those features,
and any additional constraints that must be satisfied for a valid
configuration.

To generate a feature model for Piccolo, run this command (but see note below):

```sh
besspin-feature-extract tutorial/piccolo.toml synthesize
```

This will generate `piccolo.cfr`, a Clafer file that describes the feature
model of the Piccolo design.  However, feature model synthesis can be quite
slow: the command given above may take 1.5 hours or more to complete, as it
must test over 700 different configurations of Piccolo.  Also, testing Piccolo
configurations requires a working version of the BlueSpec compiler (`bsc`) to
be available in `$PATH`.  If you prefer not to wait, or do not have `bsc` set
up, you can use a pre-generated copy of the feature model for the remainder of
the walkthrough:

```sh
cp tutorial/piccolo-pregen.cfr piccolo.cfr
```

For more details on `besspin-feature-extract` configuration and subcommands, see
[the full README](https://gitlab-ext.galois.com/ssith/arch-extract/#featuresynthfeaturesynthrkt-besspin-feature-extract).


### Feature model configuration

The BESSPIN configurator provides a graphical interface for selecting a single
configuration of a design from the full range of valid configurations described
by a feature model.

The BESSPIN configurator is implemented as a browser-based application.  To
start the configurator's server component, run:

```sh
besspin-configurator
```

Then open a web browser to the URL
[http://localhost:3784](http://localhost:3784) to access the configurator UI.

To configure the Piccolo feature model, begin by clicking "Upload Model" and
selecting the `piccolo.cfr` file generated during the previous feature model
extraction step.  (If you prefer, you can instead use the pregenerated
`examples/piccolo-pregen.cfr`.)  The configurator will display the feature
model in graphical form, which looks like this:

![](tutorial/piccolo-configurator.png
    "Piccolo feature model as displayed in the BESSPIN configurator")

Some features are already configured.  These are shown in green for enabled
features, or red for disabled ones.   For these features, either the feature
model extraction tool was configured to only consider configurations where the
feature is enabled/disabled, or the tool's analysis indicated that every valid
configuration requires the feature to be enabled/disabled.

Features shown in white are not yet configured.  To complete the configuration,
you must decide whether to enable or disable each unconfigured feature.  Click
once on an unconfigured feature to mark it as enabled (indicated by the feature
turning green), and click a second time to disable it (turning it red).  Click
and drag or use the scroll wheel to navigate around the graph.

Future versions of the configurator will further assist in choosing valid
configurations by automatically checking partial configurations for
inconsistencies and by marking features that must be enabled/disabled as a
consequence of previous selections.

Once the feature model is fully configured, click "Process Configurations" to
generate a new, fully configured Clafer file, and click "Download Configured
Model" to save it.


### Compiling the configured design

To compile a version of Piccolo using the configuration described by a fully
configured feature model, use the `besspin-build-configured-piccolo` script:

```sh
mkdir -p piccolo-build
cd piccolo-build
besspin-build-configured-piccolo ../../Piccolo ../piccolo.cfr.configured
```

This script will process `piccolo.cfr.configured` to obtain a configuration, or
will report an error if the configuration represented by that file is not
valid.  Currently it may be difficult to produce a valid configured model due
to limitations of the configurator, so if the build script produces the error
"model is unsatisfiable", try using the known-good configured model from
`tutorial/piccolo.cfr.configured` instead.

After obtaining a configuration, the `besspin-build-configured-piccolo` script
will elaborate the Piccolo sources to Verilog using that configuration.  This
requires a working version of the BlueSpec compiler (`bsc`) to be available in
your `$PATH`.  On success, it creates a `Verilog_RTL` subdirectory and fills it
with generated Verilog files.  Further steps, such as building a simulator from
the Verilog, currently must be performed manually; future versions of the
script may incorporate these steps.


### Run processor benchmarks

Program the FPGA with a pre-built GFE bitstream:

```sh
gfe-program-fpga bluespec_p1
```

This command requires a working version of the `vivado_lab` binary to be
present in `$PATH`.

Next, unpack the pre-built benchmark binaries:

```sh
besspin-unpack-coremark-builds
besspin-unpack-mibench-builds
```

Finally, load and run the benchmarks:

```sh
gfe-run-elf --runtime 30 coremark-builds/coremark-p1.bin
gfe-run-elf --runtime 30 mibench-builds/p1/aes.bin
```

For each run, `gfe-run-elf` should print some startup lines as it loads the
benchmark, followed by statistics produced by the selected benchmark program.

The `mibench-builds/p1` directory has a variety of additional benchmarks beyond
AES.  Note that some benchmarks may need more than 30 seconds of run time to
complete.  If a benchmark prints some messages but doesn't appear to complete,
try increasing the `--runtime` timeout is too short.


### Trace information leakage

The `besspin-halcyon` tool analyzes signals within a design to identify
possible sources of information leakage.
[Limitations of the tool](https://gitlab-ext.galois.com/ssith/halcyon/issues/1)
currently prevent it from working on the latest GFE processors, but it can
still be tested on a previous version of the BOOM CPU:

```sh
besspin-unpack-halcyon-boom-verilog
besspin-halcyon halcyon-boom-verilog/*.v
```

This will start the Halcyon information leakage tool, which will prompt for a
signal name. Use tab completion to list available modules and signals.
For example, enter:

```
>> MulDiv.io_resp_valid
```

Halcyon will produce a report such as this:

```
found timing leak:
    MulDiv.clock

found non-timing leak:
    MulDiv.io_kill MulDiv.io_req_bits_dw MulDiv.io_req_bits_fn
    MulDiv.io_req_bits_in1 MulDiv.io_req_bits_in2 MulDiv.io_req_ready
    MulDiv.io_req_valid MulDiv.io_resp_ready MulDiv.reset
```

This shows that observing the value of the `MulDiv.io_resp_valid` signal may
reveal timing information derived from `MulDiv.clock`, as well as information
about the values of `MulDiv.io_kill` and several other signals.

For more information on Halcyon, see
[its README](https://gitlab-ext.galois.com/ssith/halcyon).


### Run buffer overflow tests

The `besspin-bofgen` tool generates randomized C programs, each containing a
random instance of a buffer overrun.  It also comes with a test harness for
running those tests under a CPU simulator.

Begin by unpacking the test harness:

```sh
besspin-unpack-bof-test-harness
cd bof-test-harness
```

Generate 20 random buffer overflow tests:
```sh
besspin-bofgen -n 20
```

This creates a directory `output/<timestamp>` containing a number of C programs
and log files.

Use the test harness Makefile and scripts to
compile and run each test program on a pre-built Verilator simulation of Piccolo.
Compilation and program output is logged individually for each C file,
and summarized in a dashboard plot.
```sh
GCC=riscv32im-unknown-elf-gcc ./run.py output/<timestamp>/
./count.py output/<timestamp>/
./count.py -t output/<timestamp>/ | ./plot.py -o dashboard.png
```

The alternate GCC version is (temporarily) needed to support the included simulator,
which is based on an older version of Piccolo that is not compatible with the
current GFE RISC-V toolchain.
This is a [known issue](https://gitlab-ext.galois.com/ssith/testgen/issues/2)
and will be fixed in an upcoming release.

For more information on test generation and the test harness,
see the [bofgen documentation](https://gitlab-ext.galois.com/ssith/testgen).


## Components

Within the Nix shell, the following tools are available.
See the linked documentation for more detailed usage instructions.

* [Architecture and feature model extraction](https://gitlab-ext.galois.com/ssith/arch-extract):
  - `besspin-arch-extract` generates visualizations of processor architectures
  - `besspin-feature-extract` generates a Clafer model of processor features

* The graphical [feature model configurator](https://gitlab-ext.galois.com/ssith/feature-model-configurator-ui):
  - `besspin-configurator` starts a local web server where you can upload
    a Clafer file for interactive configuration.
  - [`clafer`](https://gitlab-ext.galois.com/ssith/clafer) lets you work with
    feature models from the command line.

* `besspin-build-configured-piccolo`: Helper script to build Verilog sources
  for Piccolo, using a fully-configured feature model to select processor features.

* Performance benchmarks:
  - `besspin-unpack-mibench-builds`: Unpacks binary builds of [mibench2](https://gitlab-ext.galois.com/ssith/mibench2/tree/ssith) for the GFE P1 and P2 processors
  - `besspin-unpack-mibench-src`: Unpacks [mibench2](https://gitlab-ext.galois.com/ssith/mibench2/tree/ssith) source code
  - `besspin-unpack-coremark-builds`: Unpacks binary builds of [CoreMark](https://gitlab-ext.galois.com/ssith/coremark/tree/ssith) for the GFE P1 and P2 processors
  - `besspin-unpack-coremark-src`: Unpacks [CoreMark](https://gitlab-ext.galois.com/ssith/coremark/tree/ssith) source code

* [Halcyon](https://gitlab-ext.galois.com/ssith/halcyon):
  an information-flow tracing static analysis tool for Verilog source.
  A binary version is included. It requires the commercial
  [Verific](https://www.verific.com/) library to build.
  - `besspin-halcyon <files>` prompts for a signal name.

* RISC-V [timing tests](https://gitlab-ext.galois.com/ssith/riscv-timing-tests) do
  not currently have a working demo. This will be addressed in an upcoming release.
  - `besspin-timing-test-driver`: Test driver for Rocket and BOOM.

  - `besspin-timing-test-latency`: Test baseline processor latency on no-op instructions. 

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

* Wrappers for GFE functionality:
  - `gfe-program-fpga` loads a bitstream into the FPGA
  - `gfe-run-elf` loads and executes a RISC-V binary, printing its output

Additionally, we include two stand-alone
[proof-of-concept (PoC) exploits](https://gitlab-ext.galois.com/ssith/poc-exploits)
for the *Buffer Overflow* and *Information Exposure* SSITH vulnerability classes.
These contain code samples, detailed discussion, and analysis.
Run `besspin-unpack-poc-exploits` to copy these into the working directory.
