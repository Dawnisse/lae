
########################
##   slide switches   ##
########################


#set_property -dict { PACKAGE_PIN A8   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]   ; #IO_L12N_T1_MRCC_16 Sch=sw[0]
#set_property -dict { PACKAGE_PIN C11  IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]   ; #IO_L13P_T2_MRCC_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN C10  IOSTANDARD LVCMOS33 } [get_ports { sw[2] }]   ; #IO_L13N_T2_MRCC_16 Sch=sw[2]
#set_property -dict { PACKAGE_PIN A10  IOSTANDARD LVCMOS33 } [get_ports { sw[3] }]   ; #IO_L14P_T2_SRCC_16 Sch=sw[3]



##################
##   RGB LEDs   ##
##################

#set_property -dict { PACKAGE_PIN E1  IOSTANDARD LVCMOS33 } [get_ports { led0_b }]   ; #IO_L18N_T2_35 Sch=led0_b
