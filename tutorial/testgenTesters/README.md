## Testgen Testers ##

This directory has a set of `ini` files to test testgen. This directory should be updated each release.

### Naming convention ###

* Each file starts with `test_` and ends with `.ini`.

* Configurations that need to be run on an FPGA host have the `fpga` keyword in them.

* Configurations that will open an interactive mode while running have the `dbg` keyword in them. Those are not going to end on their own and need a user intervention to terminate.

* Digits in the end are just for enumeration.

* The dimensions that are being covered are: `vulClasses`, `backend`, `osImage`, `pocExploitsMode`, and `debugMode`.

### Release 4.2 ###

  1. **`test_fpga_1.ini`:** All possible classes on FPGA on FreeRTOS.   
      * No errors should be reported, i.e. No line starts with `Error in`.  
      * Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` 
      * All the tables' rows have `V-HIGH` in the overall `Score` column except what is mentioned below.
  2. **`test_fpga_2.ini`:** All possible classes on FPGA on Debian.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` 
      * All the tables' rows have `V-HIGH` in the overall `Score` column except what is mentioned below.
  3. **`test_3.ini`:** All possible classes on Qemu on FreeRTOS.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * Each class should show `testgen_{vulClass^}.sh: qemu emulation ran successfully.` 
      * All the tables' rows have `V-HIGH` in the overall `Score` column except what is mentioned below.
  4. **`test_4.ini`:** All possible classes on Qemu on Debian.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * Each class should show `testgen_{vulClass^}.sh: qemu emulation ran successfully.` 
      * All the tables' rows have `V-HIGH` in the overall `Score` column except what is mentioned below.
  5. **`test_fpga_5.ini`:** All possible poc-exploits classes on FPGA on FreeRTOS.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * The exploits runs should be shown on the screen (The test details are shown on the screen).
      * Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` 
  6. **`test_fpga_dbg_6.ini`:** All possible poc-exploits classes on FPGA on Debian with `debugMode` ON.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * The exploits runs should be shown on the screen (The test details are shown on the screen).
      * The tool should show `emulateTests.{vulClass}: Entering interactive mode.` Pressing enter should get you a terminal-like interface.
      * Enter `--exit` to exit the debug mode.
      * Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` after debian shuts down.
  7. **`test_7.ini`:** All possible poc-exploits classes on Qemu on FreeRTOS.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * The exploits runs should be shown on the screen (The test details are shown on the screen).
      * Each class should show `testgen_{vulClass^}.sh: qemu emulation ran successfully.` 
  8. **`test_dbg_8.ini`:** All possible poc-exploits classes on Qemu on Debian with `debugMode` ON.
      * No errors should be reported, i.e. No line starts with `Error in`.
      * The exploits runs should be shown on the screen (The test details are shown on the screen).
      * The tool should show `emulateTests.{vulClass}: Entering interactive mode.` Pressing enter should get you a terminal-like interface.
      * Use `Ctrl + E` to exit the debug mode.
      * Each class should show `testgen_{vulClass^}.sh: qemu emulation ran successfully.` after debian shuts down.


### Scores Exceptions ###

* Test-457 in numeric errors reports `HIGH` in debian.
* Any bufferErrors test could report `HIGH` if the reported number of uncaught runs is really lower than average. This might happen with a low number of runs, but it should not happen often. Statistically, two tests maximum within the same run. 