# KR260 Example - PL UART and GPIO

The following project is an example design of how to create a PL UART And GPIO
and control the interfaces via Software.

The Software will connect to the PL UART, receive input from the user via console
Then if user enters 1 turn on LED1, if 2 turn on LED2, if 3 turn on LED3,
if user enters 4 turn on all LEDs, and if user enters 0 turn 0ff all LEDs.


To build the Firmware run the followings from the hardware folder:

```shell
cd hardware
source ./synth.tcl
create_target
```

To build the Software run the followings from the root folder of the repo after
opening the xsct command line:

```shell
source ./script/sw_setup.tcl
proj_create
proj_build
source ./script/sw_run.tcl
```
