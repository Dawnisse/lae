#-----------------------------------------------------------------------------------------------------
#                               University of Torino - Department of Physics
#                                   via Giuria 1 10125, Torino, Italy
#-----------------------------------------------------------------------------------------------------
# [Filename]       ShiftRegister.xdc
# [Project]        Advanced Electronics Laboratory course
# [Author]         Luca Pacher - pacher@to.infn.it
# [Language]       Xilinx Design Constraints (XDC) Tcl commands
# [Created]        May 13, 2020
# [Modified]       -
# [Description]    Implementation constraints for ShiftRegister module.
#
# [Notes]          All pin positions and electrical properties refer to the Digilent Arty A7
#                  development board. The complete .xdc file can be downloaded from official
#                  Digilent GitHub repository at :
#
#                     https://github.com/Digilent/Arty/blob/master/Resources/XDC/Arty_Master.xdc
#
#                  To find actual physical locations of pins on the board, please check Arty
#                  reference board schematics :
#
#                     https://reference.digilentinc.com/_media/arty:arty_sch.pdf
#
# [Version]        1.0
# [Revisions]      13.05.2020 - Created
#-----------------------------------------------------------------------------------------------------



##############################################
##   physical constraints (ports mapping)   ##
##############################################

## on-board 100 MHz clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]


## slide switch
set_property -dict { PACKAGE_PIN A8   IOSTANDARD LVCMOS33 } [get_ports LOAD]


## PMOD header JA
set_property -dict { PACKAGE_PIN G13  IOSTANDARD LVCMOS33 } [get_ports { PDATA[0] }]
set_property -dict { PACKAGE_PIN B11  IOSTANDARD LVCMOS33 } [get_ports { PDATA[1] }]
set_property -dict { PACKAGE_PIN A11  IOSTANDARD LVCMOS33 } [get_ports { PDATA[2] }]
set_property -dict { PACKAGE_PIN D12  IOSTANDARD LVCMOS33 } [get_ports { PDATA[3] }]
set_property -dict { PACKAGE_PIN D13  IOSTANDARD LVCMOS33 } [get_ports { PDATA[4] }]
set_property -dict { PACKAGE_PIN B18  IOSTANDARD LVCMOS33 } [get_ports { PDATA[5] }]
set_property -dict { PACKAGE_PIN A18  IOSTANDARD LVCMOS33 } [get_ports { PDATA[6] }]
set_property -dict { PACKAGE_PIN K16  IOSTANDARD LVCMOS33 } [get_ports { PDATA[7] }]


## PMOD Header JB
set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports SI]
set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports SO]


###########################################
##   timing and electrical constraints   ##
###########################################

## just for reference, the default unit of capacitance is pF, but can be changed using the set_units command
set_units -capacitance pF

## on-board 100 MHz clock (default time unit in XDC is ns)
create_clock -period 10.000 -name clk -waveform {0.000 5.000} -add [get_ports clk]

## what happens if we declare 1 GHz clock instead ?
#create_clock -period 1.000 -name clk -waveform {0.000 0.500} -add [get_ports clk]

## **WARN: the load capacitance is used during power analysis when running the report_power command, but is not used during timing analysis
set_load 10 [all_outputs]

## assume 2 ns input delay for all input signals
set_input_delay 2.0 [all_inputs]

