#
# Example Tcl script to create a Vivado project
#


## project name
set projectName arty7

## project directory
set projectDir  [pwd]/work/impl ; file mkdir ${projectDir}


#
# Resulting directories tree:
#
# ./work/impl/${projectName}.xpr
# ./work/impl/${projectName}.cache/
# ./work/impl/${projectName}.hw/
# ./work/impl/${projectName}.ip_user_files/
# ./work/impl/${projectName}.sim/
# ./work/impl/${projectName}.srcs/
#

## target FPGA (Digilent Arty-7 board)
set targetFpga {xc7a35ticsg324-1L}      ; ## **NOTE: if the design uses IPs compiled targeting a specific device, the part has to match the project !


## create a new project
create_project -force -part ${targetFpga} ${projectName} ${projectDir} -verbose

