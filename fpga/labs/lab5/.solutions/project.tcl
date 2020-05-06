#
# Example Tcl script to create a Vivado project
#


## project name
set projectName arty7
set projectDir  [pwd]/work/impl ; file mkdir ${projectDir}


#
# Resulting directories tree:
#
# ./work/sim/${projectName}.xpr
# ./work/sim/${projectName}.cache/
# ./work/sim/${projectName}.hw/
# ./work/sim/${projectName}.ip_user_files/
# ./work/sim/${projectName}.sim/
# ./work/sim/${projectName}.srcs/
#

## target FPGA (Digilent Arty-7 board)
set targetFpga {xc7a35ticsg324-1L}      ; ## **NOTE: if the design uses IPs compiled targeting a specific device, the part has to match the project !


## create a new project
create_project -force -part ${targetFpga} ${projectName} ${projectDir} -verbose

