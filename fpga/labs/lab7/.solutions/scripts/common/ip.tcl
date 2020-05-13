
###########################################################################################################
##   Example Tcl script to create/open a standalone IP project to compile IP cores using Xilinx Vivado   ##
###########################################################################################################

## location of IP repository
set coresDir [pwd]/cores

## target FPGA (Digilent Arty-7 board)
set targetFpga {xc7a35ticsg324-1L}

## project name and XML file (use the same default naming convention as in the GUI flow)
set projectName managed_ip_project
set projectFile ${coresDir}/${projectName}/${projectName}.xpr

## check if an IP project already exists
if { [file exists ${projectFile}] } {

   ## an IP project already exists, just re-open it (same as Manage IP > Open IP Location)
   open_project ${projectFile}

} else {

   ## create new IP project otherwise (same as Manage IP > New IP Location)
   create_project -ip -force -part ${targetFpga} ${projectName} ${coresDir}/${projectName}

   #create_project -in_memory -ip

   set_property ip_repo_paths [pwd]/cores [current_project]
   update_ip_catalog

   set_part ${targetFpga} ;   ## before the set_part command [current_project] gives an error, after the set_part command returns "New Project"

   ## **DEBUG
   puts "**INFO: Target FPGA set to [get_parts -of_objects [current_project]]"

   load_features ipintegrator

}

