# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TCL script to generate Vitis platform, domain and application
# Originator: S. Janamian
# Date: 3/1/2024
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

source ./script/sw_config.tcl

# ------------------------------------------------------------------------------
#   Function to create platform, domain and application
# ------------------------------------------------------------------------------
    proc proj_create {} {
        puts "set the workstation directory"
        setws ${proj::workstation}

        puts "Create a platform"
        platform create -name ${proj::platform_name} -hw ${proj::xsa_location}

        puts "Create a domain"
        domain create -name ${proj::domain_name} -os standalone -proc psu_cortexa53_0

        # Setting the default stdin and stdout to the PL uart in the BSP
        # https://docs.xilinx.com/r/en-US/ug1400-vitis-embedded/Modifying-BSP-Settings
        bsp config stdin ${proj::uart_name}
        bsp config stdout ${proj::uart_name}
        bsp regenerate

        puts "Build platform"
        platform -generate

        puts "Create an application"
        app create -name ${proj::app_name} \
            -platform ${proj::platform_name} \
            -domain ${proj::domain_name} \
            -template "Empty Application (C++)" -lang c++
        # app create -name ${proj::app_name} \
        #     -platform ${proj::platform_name} \
        #     -domain ${proj::domain_name} \
        #     -template "Empty Application(C)"
    }

    proc proj_build {} {
        app build -name ${proj::app_name}
    }
