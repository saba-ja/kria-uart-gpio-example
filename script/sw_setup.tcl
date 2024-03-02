# ------------------------------------------------------------------------------
# TCL script to generate Vitis platform, domain and application
#
# ------------------------------------------------------------------------------
namespace eval proj {

# ------------------------------------------------------------------------------
#   Global variables
# ------------------------------------------------------------------------------
    set platform_name "proj_platform"
    set domain_name   "proj_domain"
    set app_name      "proj_app"
    set xsa_location  "./export/system_wrapper.xsa"
    set uart_name     "axi_uartlite_0"
    set workstation   "./software"

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
#   Function to create platform, domain and application
# ------------------------------------------------------------------------------
    proc create {} {
        puts "set the workstation directory"
        setws ${workstation}

        puts "Create a platform"
        platform create -name ${platform_name} -hw ${xsa_location}

        puts "Create a domain"
        domain create -name ${domain_name} -os standalone -proc psu_cortexa53_0

        # Setting the default stdin and stdout to the PL uart in the BSP
        # https://docs.xilinx.com/r/en-US/ug1400-vitis-embedded/Modifying-BSP-Settings
        bsp config stdin ${uart_name}
        bsp config stdout ${uart_name}
        bsp regenerate

        puts "Build platform"
        platform -generate

        puts "Create an application"
        app create -name $app_name -platform $platform_name \
            -domain $domain_name -template "Empty Application (C++)" -lang c++
    }

    proc build {} {
        app build -name proj_app
    }
# ------------------------------------------------------------------------------
#   Function to boot the device and run the bare-metal application
# ------------------------------------------------------------------------------
    proc run {} {
        puts "Connect"
        connect

        puts "set boot mode to jtag"
        boot_jtag

        puts "List targets"
        targets

        puts "set targetr to PSU"
        targets -set -filter {name =~ "PSU"}

        puts "Configure the FPGA"
        # When the active target is not a FPGA device, 
        # the first FPGA device is configured
        fpga "${workstation}/proj_platform/hw/system_wrapper.bit"

        puts "Source the psu_init.tcl script and run psu_init cmd to init PS"
        source "${workstation}/proj_platform/hw/psu_init.tcl"
        psu_init
        
        puts "PS-PL power isolation must be removed and PL reset must"
        puts "be toggled, before the PL address space can be accessed"
        
        # Some delay is needed between these steps
        after 1000
        psu_ps_pl_isolation_removal
        
        after 1000
        psu_ps_pl_reset_config
        
        puts "Select A53 #0 and clear its reset"
        targets -set -filter {name =~ "Cortex-A53 #0"}
        
        puts "reset processor"
        rst -processor
        
        puts "Download the application program"
        dow "${workstation}/proj_app/Debug/proj_app.elf"

        puts "Run the application"
        con
    }
}
