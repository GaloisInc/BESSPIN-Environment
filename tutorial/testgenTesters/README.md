## Testgen Testers ##

This directory has a set of `ini` files to test testgen. This directory should be updated each release.

### Naming convention ###

* Each file starts with `test_` and ends with `.ini`.

* Digits after `test_` are just for enumeration.

* Configurations that need to be run on an FPGA host have the `fpga` keyword in them.

* Configurations that will open an interactive mode while running have the `dbg` keyword in them. Those are not going to end on their own and need a user intervention to terminate.

* The dimensions that are being covered are: `vulClasses`, `backend`, `processor`, `osImage`, `pocExploitsMode`, and `debugMode`.

### Release 4.2 ###

  1. **`test_01_fpga.ini`:** All possible classes on FPGA on FreeRTOS. `chisel_p1`.
      * No errors should be reported, i.e. No line starts with `Error in`.  
      * Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` 
      * All the tables' rows have `V-HIGH` in the overall `Score` column except what is mentioned below.
  2. **`test_02_fpga.ini`:** All possible classes on FPGA on FreeRTOS. `bluespec_p1`.
      * Same as `test_01_fpga.ini`.
  3. **`test_03_fpga.ini`:** All possible classes on FPGA on Debian. `chisel_p2`.
      * Same as `test_01_fpga.ini`.
  4. **`test_04_fpga.ini`:** All possible classes on FPGA on Debian. `bluespec_p2`.
      * Same as `test_01_fpga.ini`.
  5. **`test_05.ini`:** All possible classes on Qemu on FreeRTOS.
      * Same as `test_01_fpga.ini`, except the word `qemu` instead of `fpga`.
  6. **`test_06.ini`:** All possible classes on Qemu on Debian.
      * Same as `test_01_fpga.ini`, except the word `qemu` instead of `fpga`.
  7. **`test_07_fpga.ini`:** All possible poc-exploits classes on FPGA on FreeRTOS. `chisel_p1`.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * The exploits runs should be shown on the screen (The test details are shown on the screen).
      * Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` 
  8. **`test_08_fpga_dbg.ini`:** All possible poc-exploits classes on FPGA on Debian with `debugMode` ON. `chisel_p2`.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * The exploits runs should be shown on the screen (The test details are shown on the screen).
      * The tool should show `emulateTests.{vulClass}: Entering interactive mode.` Pressing enter should get you a terminal-like interface.
      * Enter `--exit` to exit the debug mode.
      * Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` after debian shuts down.
  9. **`test_09.ini`:** All possible poc-exploits classes on Qemu on FreeRTOS.
      * Same as `test_07_fpga.ini`, except the word `qemu` instead of `fpga`.
  10. **`test_10_dbg.ini`:** All possible poc-exploits classes on Qemu on Debian with `debugMode` ON.
      * Same as `test_08_fpga_dbg.ini`, except: the word `qemu` instead of `fpga`, and use `Ctrl+E` to exit instead of `--exit`.


### Scores Exceptions ###

* Test-457 in numeric errors reports `HIGH` in debian.
* Any bufferErrors test could report `HIGH` if the reported number of uncaught runs is really lower than average. This might happen with a low number of runs, but it should not happen often. If this happens to more than two tests within the same run, this would deserve more investigation.