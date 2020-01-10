## Testgen Testers ##

This directory has a set of `ini` files to test testgen. This directory should be updated each release.

### Naming convention ###

* Each file starts with `test_` and ends with `.ini`.

* Configurations that need to be run on an FPGA host have the `fpga` keyword in them.

* Configurations that will open an interactive mode while running have the `dbg` keyword in them. Those are not going to end on their own and need a user intervention to terminate.

* Digits in the end are just for enumeration.

* The dimensions that are being covered are: `vulClasses`, `backend`, `osImage`, `pocExploitsMode`, and `debugMode`.

### Release 4.1 ###

  1. **`test_fpga_1.ini`:** All possible classes on FPGA on FreeRTOS.   
     &mdash; Expected all classes to execute normally without any errors. Each class should show `testgen_{vulClass^}.sh: fpga emulation ran successfully.` And all the tables' rows have `V-HIGH` in the `Score` column.
  2. **`test_fpga_2.ini`:** All possible classes on FPGA on Debian.
  3. **`test_3.ini`:** All possible classes on Qemu on FreeRTOS.
  4. **`test_4.ini`:** All possible classes on Qemu on Debian.
  5. **`test_fpga_5.ini`:** All possible poc-exploits classes on FPGA on FreeRTOS.
  6. **`test_fpga_dbg_6.ini`:** All possible poc-exploits classes on FPGA on Debian with `debugMode` ON.
  7. **`test_7.ini`:** All possible poc-exploits classes on Qemu on FreeRTOS.
  8. **`test_dbg_8.ini`:** All possible poc-exploits classes on Qemu on Debian with `debugMode` ON.