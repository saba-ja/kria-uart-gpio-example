# ------------------------------------------------------------------------------
#  IO Map
# ------------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports {uart_rtl_rxd}]
set_property -dict {PACKAGE_PIN E10 IOSTANDARD LVCMOS33} [get_ports {uart_rtl_txd}]
set_property -dict {PACKAGE_PIN J11 IOSTANDARD LVCMOS33} [get_ports {led_tri_o[0]}]
set_property -dict {PACKAGE_PIN J10 IOSTANDARD LVCMOS33} [get_ports {led_tri_o[1]}]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {led_tri_o[2]}]
set_property -dict {PACKAGE_PIN AE12 IOSTANDARD LVCMOS33} [get_ports {btn_tri_i[0]}]
# ------------------------------------------------------------------------------
#  Clock Virtual clock
# ------------------------------------------------------------------------------
create_clock -add -name clk_virt_100mhz -period 10.00
# ------------------------------------------------------------------------------
#  Output Timing 
# ------------------------------------------------------------------------------
set_false_path -to {led_tri_o[0]}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {led_tri_o[0]}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {led_tri_o[0]}]

set_false_path -to {led_tri_o[1]}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {led_tri_o[1]}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {led_tri_o[1]}]

set_false_path -to {led_tri_o[2]}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {led_tri_o[2]}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {led_tri_o[2]}]

set_false_path -to {uart_rtl_txd}
set_output_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {uart_rtl_txd}]
set_output_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {uart_rtl_txd}]
# ------------------------------------------------------------------------------
#  Input Timing
# ------------------------------------------------------------------------------
set_false_path -from {btn_tri_i[0]}
set_input_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {btn_tri_i[0]}]
set_input_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {btn_tri_i[0]}]

set_false_path -from {uart_rtl_rxd}
set_input_delay -clock [get_clocks clk_virt_100mhz] -min -add_delay 1.000 [get_ports {uart_rtl_rxd}]
set_input_delay -clock [get_clocks clk_virt_100mhz] -max -add_delay 2.000 [get_ports {uart_rtl_rxd}]

