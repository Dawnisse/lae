#######################################
##   on-board 100 MHz clock signal   ##
#######################################

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} -add [get_ports clk]


##################################
##   start/reset push-buttons   ##
##################################

set_property -dict { PACKAGE_PIN D9  IOSTANDARD LVCMOS33 } [get_ports rst] ;  # BTN0 - reset


####################
##   status LED   ##
####################

#set_property -dict { PACKAGE_PIN H5  IOSTANDARD LVCMOS33 } [get_ports LED] ;     # LED0


############################
##   USB/UART interface   ##
############################

set_property -dict { PACKAGE_PIN D10  IOSTANDARD LVCMOS33 } [get_ports TxD]
#set_property -dict { PACKAGE_PIN A9   IOSTANDARD LVCMOS33 } [get_ports RxD]

