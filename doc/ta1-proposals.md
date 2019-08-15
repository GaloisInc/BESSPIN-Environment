# SSITH TA1 Proposal Summaries

The BESSPIN Tool Suite should offer relevant and effective functionality
for measuring and assessing the security claims made by TA1 designs.
This is my attempt to provide a concise and focused technical summary of those specific claims for each of
[the accepted TA1 proposals](https://drive.google.com/open?id=0B6f4xBqhi70Wd2xybG4yeFloVHc).

-- Max


## Draper / UPenn / MIT / PSU / INRIA / DornerWorks / Dover

The Draper team shows their dedication with a Star Wars pun in the project title:
"Advanced New Hardware Optimized for Policy Enforcement, **A New HOPE**".
Their architecture is called **PIPE**: Processor Interlocks for Policy Enforcement.
PIPE implements reprogrammable, general purpose tagged memory with minimal modification of the host processor.
A modified SoC mediates all application memory access through a
Policy Execution (PEX) system with its own policy memory, rule cache, and tag map.
Policy memory stores executable policy functions and metadata records, 
which are associated with each word of application memory through the tag map.
Hardware interlocks intercept all pending instructions and memory updates issued by the host CPU,
checking them first against cached rules and then, if lookup fails, stored policy functions.
Approval generates a new rule entry for the cache.
Violation triggers an interrupt on the host CPU,
and optionally taints the PC with violation-specific metadata
that can be read by subsequent policy checks.
Policies are compiled from a DSL.
Metadata is generated and assigned to application memory
either through static analysis or a modified compiler toolchain.
Policy binaries, metadata, and tag map are installed at boot time.

Select claims:
- "a security architecture and associated design tools that comprehensively address all CWE classes enumerated in the SSITH BAA"
- "a framework for trading key performance metrics against well-defined security guarantees"
- "The HOPE security architecture can directly enforce Information Flow Control (IFC) security policies"
- "the ability to securely log all policy-related events"
- "will run C/C++ applications with little or no modification"
- "using policies with small, fixed numbers of tags, we incur zero performance penalty after cache warmup"
- "an analysis workbench that explores the space of policy combinations and architecture parameter values"
- "HOPE will formally define the meaning of security policies"
- "methods for formally stating system-level security requirements, in collaboration with TA-2"

The PIPE system should be capable of mitigating a wide range of vulnerabilities,
but relies on appropriate policies being available, correct, and efficient.
Draper is developing a policy library and related tools as part of HOPE.
The library will include policies covering vulnerability examples from all seven SSITH CWE classes.
The proposal includes a table relating policies to vulnerability classes, which I've copied below.

Table 1. Sample HOPE Policies, by CWE class:

| CWE Class | Security Architecture Policies |
| --------- | ------------------------------ |
| Buffer Errors | Heap memory “coloring”, Stack control data safety, Substructural memory integrity |
| Permission, Privileges, Access Control | Software Fault Isolation, Mandatory Access Control, Multi-Level Security (MLS) |
| Resource Management | Mandatory Access Control |
| Code Injection | RWX (Read, Write, eXecute) |
| Information Leakage | Taint tracking, Multi-Level Security |
| Crypto Errors | Key confidentiality and access control, Encrypt-before-send confidentiality |
| Numeric Errors | Numeric bounds |


## U. Michigan / UT Austin

The Michigan team's architecture is called **EMTD**, Ensembles of Moving Target Defenses.
The idea is to protect a system's key information assets (listed below) through
combinations of *encryption*, *reinterpretation*, and *churn*.

- Instruction set
- Program code
- Program code address locations
- Relative distance of program parts
- Data representation
- Data values
- Data value address locations
- Relative distance of data elements
- Relative distance of code and data
- Code access latency
- Code execution latency

It was not clear to me from the proposal exactly how or where the three MTDs will be implemented.
The authors mention tagged memory, random number generation, traffic shaping and noise injection,
multiplexed decoders, and some other mechanisms.
Presumably these will be implemented within the processor architecture,
in some cases with compiler or run-time software support.
The proposal also mentions anomaly detection, specifically applied to resource management.

The security claims are given in terms of *periodic churn cost*
and *maximum vulnerability period*.
These are proposed performance cost and security strength metrics for EMTD systems.
The authors claim that combinations of their three basic techniques will
protect against all seven vulnerability classes,
but each technique may have multiple implementations within an EMTD system.


## Columbia / Stanford / Brown

Dropped from SSITH; skipping.


## Lockheed / Binghamton U.

The Lockheed Martin team is developing an architecture called **HARD**,
Hardware Architecture Resilience by Design.
It uses a combination of seven different techniques to protect against the seven vulnerability classes, as shown below:

Table 1. The Hardware Techniques Selected will Provide Protection against the Seven (7) CWE Vulnerabilities.

| Technique: | Buffer Errors | Permissions, Privileges & Access Control | Resource Management | Code Injection | Crypto Errors | Numeric Errors | Information Leakage |
| ---------- | ------------- | ---------------------------------------- | ------------------- | -------------- | ------------- | -------------- | ------------------- |
| 1 Data word tagging                                                           | X |   |   | X | X |   | X |
| 2 Instruction word tagging                                                    | X |   |   | X |   |   |   |
| 3 Metadata tagging                                                            |   | X |   | X | X |   |   |
| 4 Fenced protected regions with secure pointers and automatic bounds checking | X | X | X |   | X |   |   |
| 5 Protection domains with fast local exception handlers                       |   | X | X | X | X | X |   |
| 6 Crypto engine in DRAM controller and per-thread key registers               |   | X |   |   | X | X |   |
| 7 Memory-mapped IO devices and tagging incoming data as potentially tainted   |   | X | X | X |   |   |   |

Each of these approaches are detailed in the proposal.
A Clang-based compiler and customized Linux OS are being developed in support of the architecture features.


# MIT / Accellerated Tech

The MIT team is developing **HSC**, the Hardware Security Compiler:
"an EDA tool allowing software-security experts to prototype new hardware extensions, without hardware expertise".
It is designed around Kami formal verification of Bluespec HDL code. 
The processor architecture itself is called Sanctum, and provides enclave-based process isolation.
While MIT will deliver verified demonstration processors,
they consider their major contribution to be tooling and verification workflow.

The team-specific metrics proposed are
- *end-to-end assurance level*: the size of trusted code base needed to ensure compliance with system datasheet specifications
- *development agility*: the speed with which team members can create effective hardware mitigations for new vulnerabilities

As part of their development effort, they will deliver a library of
parameterized hardware modules (IP blocks) with correctness proofs showing
that their observable behaviors do not deviate from simpler reference implementations, which serve as module specs.
The module interfaces leverage Bluespec language features for latency-insensitive transactions.

The proposal includes discussion of specific mitigation strategies for the seven vulnerability classes
with example definitions of *properties*, which are computed metadata for values in memory.
These include tagging schemes and various forms of bounds checking.
Responses to detected security violations are implemented as exception handlers in firmware.


# UCSD

The UCSD proposal describes an unnamed *context-sensitive instruction decoding* architecture
which uses machine learning techniques on instrumented hardware to detect and classify attacks,
and responds by dynamically changing the translation between the native ISA
and the microcode of the system's internal ISA.
They claim that this approach will allow for minimal changes to the processor design,
low impact on performance, and no changes to software.

The internal ISA employs *decoy micro-ops* which cannot be seen or modified
by running software. These implement the following mitigation strategies:
- bounds checking
- code-pointer integrity checks
- control-data isolation
- type-safety enforcement
- compartmentalization
- capability checks
- side-channel obfuscation
- custom performance counters for malware detection

Table 2 in the proposal describes how these defense strategies apply to the seven vulnerability classes:

| CWE Class: | Defense |
| ---------- | ------- |
| Information Leakage | Attacker-oblivious obfuscation of information leaked via side-channels. |
| Buffer Errors | Bounds checking using Hardbound and CHERI-like capabilities, and stack-smashing protection using decoy micro-ops. |
| Permissions, Privileges, and Access Control | Integrity-checks and authorization policy enforcement using more advanced capabilities. |
| Resource Management | Expanding capability-based access control checks across different microarchitectural structures and peripherals. |
| Crypto Errors | Improved random number generation and secondary key generation. |
| Code Injection | Decoy micro-ops for code-pointer integrity and control-data isolation. |
| Numeric Errors | Strong type-safety enforcement for numeric data types using overflow checks. |

They plan to implement this approach using several hardware-accelerated classifier designs,
first with an Intel ISA front-end and later for ARM and RISC-V ISAs.
Early deliverables are focused on Gem5 simulation,
with prototype FPGA implementations of the detector and decoder designs following in Phase 2 and 3.
The proposal does not appear to promise a complete working RISC-V processor design at any point in the program. 


# Cornell

Dropped from SSITH; skipping.


# SRI / Cambridge / ARM

The Cambridge team is continuing work on secure SoC architectures called **CHERI**,
Capability Hardware Enhanced RISC Instructions, which was initially developed within the DARPA CRASH program.
Under SSITH, they intend to adapt CHERI both to different types of application processor cores
and to other SoC IP blocks such as DMA engines.
The initial CHERI work produced an open-source 64-bit MIPS platform,
which they are adapting to ARM SoC designs with their industrial partners ARM Inc.
In particular, they are developing "MICRO" and "LIGHT" versions of CHERI for
32-bit MIPS, ARM M-Profile, and 32-bit RISC-V cores.
CHERI-MICRO features 64-bit compressed capability words for 32-bit pointers,
and CHERI-LIGHT has a reduced set of register-only capabilities for special-purpose processors.
Only CHERI-LIGHT will be implemented for a 32-bit RISC-V DMA engine.
No general-purpose or 64-bit RISC-V SoC appears in the proposal.

The CHERI protection model focuses on various means of
enforcing *privilege minimization* and *intentional use*.
The basic mechanism used is capability metadata for C/C++ pointers,
which requires compiler toolchain and OS support.
They are developing versions of Clang/LLVM, FreeBSD, and their own compartmentalization tool
called SOAAP (Security-Oriented Analysis of Application Programs).

Their approaches to the seven vulnerability classes are summarized in proposal section B.6.

In brief, they expect to mitigate the *Buffer Errors*, *Information Leakage*,
and *Permission, Privileges, and Access Control* CWE classes with no changes to application code.

For *Resource Management*: "We will analyze capability-aware I/O devices and interconnect
filtering to demonstrate that improper use of hardware resources is not permitted."

For *Code Injection*: "Guarded manipulation of CHERI capabilities prevents confusion over
data and code regions. ... We will demonstrate that non-processor DMA devices cannot inject code."

For *Crypto Errors*: "We will demonstrate that capability-enabled compartmentalization can
be extended to include an enclave processor providing crypto services. We will explore the
use of compartmentalization for trustworthy key management, and other aspects of cryp-
tographic composability."

For *Numerical Errors*: "Our primary focus is integrity of references and pointers to ensure
that numerical errors cannot result in escalating access to more resources. In particular, this
will meet the CWE-7 subchallenges: (a) improper validation of array index, and (b) numeric
range comparison without minimum check."
