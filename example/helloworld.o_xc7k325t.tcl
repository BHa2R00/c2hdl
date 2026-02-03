read_verilog helloworld.o_xc7k325t.sv
synth_design -verilog_define XILINX= -part xc7k325t-ffg676-1 -top helloworld_xc7k325t 
set_property PACKAGE_PIN AA10 [get_ports clk_p]
set_property PACKAGE_PIN AB10 [get_ports clk_n]
set_property PACKAGE_PIN D9   [get_ports rst ]
set_property PACKAGE_PIN G20  [get_ports idle ]
set_property PACKAGE_PIN F9   [get_ports stdout_tx ]
set_property PACKAGE_PIN F8   [get_ports stdin_rx ]
set_property PACKAGE_PIN H19  [get_ports debug[0] ]
set_property PACKAGE_PIN E20  [get_ports debug[1] ]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst ]
set_property IOSTANDARD LVCMOS33 [get_ports idle  ]
set_property IOSTANDARD LVCMOS33 [get_ports stdout_tx ]
set_property IOSTANDARD LVCMOS33 [get_ports stdin_rx ]
set_property IOSTANDARD LVCMOS33 [get_ports {debug[*]}]
create_clock -period [expr 1000/200] -name clk [get_ports clk_p]
opt_design 
place_design 
route_design 
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
write_bitstream -force helloworld.o_xc7k325t.bit 
write_cfgmem -format mcs -interface spix4 -size 16 -loadbit "up 0x00000000 helloworld.o_xc7k325t.bit" -checksum -force -file "helloworld.o_xc7k325t.mcs"
write_project_tcl -force helloworld.o_xc7k325t_vivado.tcl

open_hw
connect_hw_server
open_hw_target
set_property PROGRAM.FILE {helloworld.o_xc7k325t.bit} [get_hw_devices xc7k325t_0]
create_hw_cfgmem -hw_device [lindex [get_hw_devices xc7k325t_0] 0] [lindex [get_cfgmem_parts {s25fl128sxxxxxx0-spi-x1_x2_x4}] 0]
set_property PROGRAM.BLANK_CHECK  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.ERASE  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.CFG_PROGRAM  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.VERIFY  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.CHECKSUM  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.ADDRESS_RANGE  {use_file} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.FILES [list "helloworld.o_xc7k325t.mcs" ] [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.PRM_FILE {} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.UNUSED_PIN_TERMINATION {pull-none} [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.BLANK_CHECK  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.ERASE  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.CFG_PROGRAM  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.VERIFY  1 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
set_property PROGRAM.CHECKSUM  0 [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]
create_hw_bitstream -hw_device [lindex [get_hw_devices xc7k325t_0] 0] [get_property PROGRAM.HW_CFGMEM_BITFILE [ lindex [get_hw_devices xc7k325t_0] 0]]; program_hw_devices [lindex [get_hw_devices xc7k325t_0] 0]; refresh_hw_device [lindex [get_hw_devices xc7k325t_0] 0];
program_hw_cfgmem -hw_cfgmem [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xc7k325t_0] 0]]

