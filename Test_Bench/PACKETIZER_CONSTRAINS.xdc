## Clock Input (simulate a 50 MHz clock)
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 20.000 -name sys_clk -waveform {0 10} [get_ports clk]

## Reset Signal
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## UART TX Output (serial_out)
set_property PACKAGE_PIN A9 [get_ports serial_out]
set_property IOSTANDARD LVCMOS33 [get_ports serial_out]

## Data Input (data_in[7:0])
set_property PACKAGE_PIN V17 [get_ports data_in[0]]
set_property PACKAGE_PIN V16 [get_ports data_in[1]]
set_property PACKAGE_PIN W16 [get_ports data_in[2]]
set_property PACKAGE_PIN W17 [get_ports data_in[3]]
set_property PACKAGE_PIN W15 [get_ports data_in[4]]
set_property PACKAGE_PIN V15 [get_ports data_in[5]]
set_property PACKAGE_PIN T17 [get_ports data_in[6]]
set_property PACKAGE_PIN T18 [get_ports data_in[7]]
set_property IOSTANDARD LVCMOS33 [get_ports {data_in[*]}]

## Data Valid Signal
set_property PACKAGE_PIN U17 [get_ports data_valid]
set_property IOSTANDARD LVCMOS33 [get_ports data_valid]

## TX Busy (optional debug output)
set_property PACKAGE_PIN T14 [get_ports tx_busy]
set_property IOSTANDARD LVCMOS33 [get_ports tx_busy]