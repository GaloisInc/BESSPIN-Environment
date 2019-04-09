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
1. [Overview](#Overview) of tool suite workflow
2. [Tutorial](#Tutorial) example walkthrough
3. [Components](#Components) listed and linked


## Overview

The diagram below illustrates the various tool suite components
and the relationships between them.
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
The design can be tested for performance using standard benchmark suites.
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
The final section of this document lists each individual tool
and its commands, along with a link to its documentation
and source code.


## Tutorial

This section gives brief instructions in the form of a walkthrough
demonstrating all the major functionality of the BESSPIN tool suite.
More complete documentation is available for each of the [component projects](#Components)
linked to in the following section.

### Setup

The Tool Suite requires the [Nix package manager](https://nixos.org/nix/).  To
install it, follow [these instructions](https://nixos.org/nix/manual/#sect-multi-user-installation).

Once Nix is installed, run `nix-shell` in this repository.  Nix will download
and install the BESSPIN Tool Suite and its dependencies, and will open a shell
with all the commands available in `$PATH`.
The first time nix-shell is run, **it may take 2 to 3 hours to complete**.
Subsequent runs will use the locally cached Nix packages being installed,
and should finish quickly.


The remainder of this tutorial uses the Piccolo processor as a running example,
and requires a copy of the Piccolo source code to be available alongside the
`tool-suite` checkout.  The easiest way to set this up is to create a symbolic
link:

```sh
ln -s /path/to/gfe/bluespec-processors/P1/Piccolo ../Piccolo
```

### Architecture extraction and visualization

**TODO:**
- move config documentation to arch-extract repo
- condense into two quick steps: low-level + high level vis.


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

These commands generate PDF drawings showing the internal structure of
modules.  For example, the generated `piccolo-arch/mkShifter_Box.pdf` file looks
like this:

![](tutorial/piccolo-example-module.png "Piccolo mkShifter_Box module")

This visualization shows that the `mkShifter_Box` module contains several
registers and shows some of the connections between them.  (Some connections
are currently omitted due to limitations of the architecture extraction tool,
which will be corrected in future releases.)

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

The options in the `[graphviz]` section of the configuration file control the
level of detail of the generated graphs.  For example, these commands use an
alternate configuration file to generate a lower-level view of Piccolo's
modules:

```sh
besspin-arch-extract tutorial/piccolo-low-level.toml visualize
for f in piccolo-arch/*.dot; do dot -Tpdf $f -o ${f%.dot}.pdf; done
```

Now `piccolo-arch/mkShifter_Box.pdf` looks like this:

![](tutorial/piccolo-example-module-low-level.png
    "Piccolo mkShifter_Box module, low-level view")

This visualization now shows the details of nets and combinational logic
elements connected between the various registers.

A less detailed, higher-level view is also available: run the same commands
again using the `tutorial/piccolo-high-level.toml` config file instead.

### Feature model extraction

The BESSPIN feature model extraction tool tests a variety of configurations of
a design and generates a machine-readable feature model that describes the
configurable features of the design, the dependencies between those features,
and any additional constraints that must be satisfied for a valid
configuration.

To generate a feature model for Piccolo, run this command (but see note below):

```sh
besspin-feature-extract tutorial/piccolo.toml synthesize
```

This will generate `piccolo.cfr`, a Clafer file that describes the feature
model of the Piccolo design.

Note that feature model synthesis can be quite slow: the command given above
may take 1.5 hours or more to complete, as it must test over 700 different
configurations of Piccolo.  If you prefer not to wait, you can use a
pregenerated copy of the feature model for the remainder of the walkthrough:

```sh
cp tutorial/piccolo-pregen.cfr piccolo.cfr
```

Like the architecture extraction tool, `besspin-feature-extract` takes a
configuration file and a subcommand as arguments.

The configuration file, [`tutorial/piccolo.toml`](tutorial/piccolo.toml),
contains a `[featuresynth]` that configures the behavior of the feature model
extraction algorithm.  See the comments in that section for descriptions of the
supported options.

`synthesize` is the primary subcommand of `besspin-feature-extract`: it
extracts ("synthesizes") a feature model for the design described in the
configuration file.  Other subcommands are not yet finished, but will include
tools for diagnosing errors that may occur during feature model extraction.


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
extraction step.  The configurator will display the feature model in graphical
form, which looks like this:

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
turning green), and click a second time to disable it (turning it red).

Future versions of the configurator will further assist in choosing valid
configurations by automatically checking partial configurations for
inconsistencies and by marking features that must be enabled/disabled as a
consequence of previous selections.

Once the feature model is fully configured, click "Process Configurations" to
generate a new, fully configured Clafer file, and click "Download Configured
Model" to save it.  Save the file as "piccolo-configured.cfr".  (There is also
a fully-configured copy of the Piccolo feature model available as
`tutorial/piccolo.cfr.configured` in this repository.)


### Compiling the configured design

To compile a version of Piccolo using the configuration described by a fully
configured feature model, use the `besspin-build-piccolo` script:

```sh
mkdir -p piccolo-build
cd piccolo-build
besspin-build-configured-piccolo ../../Piccolo ../piccolo.cfr.configured
```

This script will process `piccolo.cfr.configured` to obtain a configuration (or
report an error if the configuration represented by that file is not valid),
then it will elaborate the Piccolo sources to Verilog using that configuration.
This requires a working copy of the BlueSpec Compiler (`bsc`) to be
available in your `$PATH`.  The remaining steps, such as building a simulator
from the generated Verilog, currently must be performed manually, but future
versions of the script may integrate these steps.


### Build simulators (???)

### Run processor benchmarks

### Trace information leakage

### Run timing tests

### Run buffer overflow tests


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
  for Piccolo, using a fully-configured feature model to select features to
  enable

* Performance benchmarks:
  - `besspin-unpack-mibench-builds`: Unpacks binary builds of [mibench2](https://gitlab-ext.galois.com/ssith/mibench2/tree/ssith) for the GFE P1 and P2 processors
  - `besspin-unpack-mibench-src`: Unpacks [mibench2](https://gitlab-ext.galois.com/ssith/mibench2/tree/ssith) source code
  - `besspin-unpack-coremark-builds`: Unpacks binary builds of [CoreMark](https://gitlab-ext.galois.com/ssith/coremark/tree/ssith) for the GFE P1 and P2 processors
  - `besspin-unpack-coremark-src`: Unpacks [CoreMark](https://gitlab-ext.galois.com/ssith/coremark/tree/ssith) source code

* [Halcyon](https://gitlab-ext.galois.com/ssith/halcyon):
  an information-flow tracing static analysis tool for Verilog source.
  - `besspin-halcyon <files>` will prompt you for a signal name.

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

Additionally, we include two stand-alone
[proof-of-concept exploits](https://gitlab-ext.galois.com/ssith/poc-exploits)
for the *Buffer Overflow* and *Information Leakage* SSITH vulnerability classes.
These contain code samples, detailed discussion, and analysis.
Run `besspin-unpack-poc-exploits` to copy these into the working directory.
