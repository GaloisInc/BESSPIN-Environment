{}:

let
  pkgs = import ../pinned-pkgs.nix {};
  inherit (pkgs) mkShell callPackage lib;
  besspin = callPackage ../besspin-pkgs.nix {};

in mkShell {
  inputsFrom = with besspin;
    [
    ];

  buildInputs = with pkgs; with besspin; [
    python3
    qemu

    riscv-gcc
    riscv-gcc-linux
    riscv-llvm
    riscv-clang
    riscv-openocd

    programFpgaWrapper
    runElf
    verilator
    riscvTestsBuildUnpacker

    simulatorBinBSV1
    simulatorBinCHSL1
    simulatorBinBSV2
    simulatorBinCHSL2
    simulatorElfToHex

    which
    netcat
  ];

  LANG = "en_US.UTF-8";

  nixpkgs = pkgs.path;


  BESSPIN_TESTGEN_BUSYBOX_IMAGE = besspin.busyboxImageQemu;
  BESSPIN_TESTGEN_DEBIAN_IMAGE = besspin.testgenDebianImageQemu;
  BESSPIN_GFE_SCRIPT_DIR = "${besspin.testingScripts}/scripts";

  inherit (besspin) debianStage1VirtualDisk;
}
