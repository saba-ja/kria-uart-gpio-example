# ------------------------------------------------------------------------------
#   Script to boot the device and run the bare-metal application
# ------------------------------------------------------------------------------

source ./script/sw_config.tcl

# ------------------------------------------------------------------------------
#   Function to set jtag as boot source
# ------------------------------------------------------------------------------
proc boot_jtag { } {
    # Switch to JTAG boot mode #
    targets -set -filter {name =~ "PSU"}
    # update multiboot to ZERO
    mwr 0xffca0010 0x0
    # change boot mode to JTAG
    mwr 0xff5e0200 0x0100
    # reset
    rst -system
}

# ------------------------------------------------------------------------------
# Program the board and run the application
# ------------------------------------------------------------------------------

puts "Connect"
connect

puts [string repeat "-" 20]
puts "set boot mode to jtag"
puts [string repeat "-" 20]

boot_jtag

puts [string repeat "-" 20]
puts "List targets"
puts [string repeat "-" 20]
puts [targets]

puts [string repeat "-" 20]
puts "set targetr to PSU"
puts [string repeat "-" 20]
targets -set -filter {name =~ "PSU"}

puts [string repeat "-" 20]
puts "Configure the FPGA"
puts [string repeat "-" 20]
# When the active target is not a FPGA device, 
# the first FPGA device is configured
fpga "${proj::workstation}/$proj::platform_name/hw/system_wrapper.bit"

puts [string repeat "-" 20]
puts "Source the psu_init.tcl script and run psu_init cmd to init PS"
puts [string repeat "-" 20]

after 1000
source "${proj::workstation}/${proj::platform_name}/hw/psu_init.tcl"
after 1000
puts [psu_init]

puts [string repeat "-" 20]        
puts "PS-PL power isolation must be removed and PL reset must"
puts "be toggled, before the PL address space can be accessed"
puts [string repeat "-" 20]

# Some delay is needed between these steps
after 1000
psu_ps_pl_isolation_removal

after 1000
psu_ps_pl_reset_config

puts [string repeat "-" 20]
puts "Select A53 #0 and clear its reset"
puts [string repeat "-" 20]

targets -set -filter {name =~ "Cortex-A53 #0"}

puts [string repeat "-" 20]
puts "reset processor"
puts [string repeat "-" 20]
rst -processor -clear-registers

puts [string repeat "-" 20]
puts "Download the application program"
puts [string repeat "-" 20]
dow "${proj::workstation}/${proj::app_name}/Debug/${proj::app_name}.elf"

puts [string repeat "-" 20]
puts "Run the application"
puts [string repeat "-" 20]
con
