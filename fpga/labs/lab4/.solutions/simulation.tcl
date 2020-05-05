
################################################################################
##   First example Tcl script to simulate an RTL design using Xilinx Vivado   ##
################################################################################

#
# **NOTE
# Type:
#
#   help -categoty Simulation
#
# at the Vivado Tcl console to get a list of all available simulation commands
#


## profiling
set tclStart [clock seconds]


##########################
##   useful variables   ##
##########################

set rtlDir       [pwd]/rtl
set ipsDir       [pwd]/cores
set benchDir     [pwd]/bench
set scriptsDir   [pwd]/scripts
set workDir      [pwd]/work/sim


#######################
##   project setup   ##
#######################

#
# **NOTE
# There is no "non-project mode" simulation Tcl flow in Vivado, the "non-project mode" flow
# requires to call standalone xvlog/xvhdl, xelab and xsim executables from the command-line
# or inside a GNU Makefile.
# However in "non-project mode" the simulation can not be re-invoked from the GUI after RTL
# or testbench changes, thus requiring to exit the GUI and re-build the simulation from scratch.
# Use therefore a "project mode" Tcl script to automate the simulation. The overhead of
# creating an in-memory project is low compared to the benefits of fully automated one-step
# compilation/elaboration/simulation and re-launch features.
#


## project name
set projectName behavioral
set projectDir  ${workDir} ; file mkdir ${projectDir}

#
# Resulting directories tree:
#
# ./work/sim/behavioral.xpr
# ./work/sim/behavioral.cache/
# ./work/sim/behavioral.hw/
# ./work/sim/behavioral.ip_user_files/
# ./work/sim/behavioral.sim/
# ./work/sim/behavioral.srcs/
#

## target FPGA (Digilent Arty-7 board)
set targetFpga {xc7a35ticsg324-1L}      ; ## **NOTE: if the design uses IPs compiled targeting a specific device, the part has to match the project !


## create a new project
create_project -force -part ${targetFpga} ${projectName} ${projectDir} -verbose



###################################################################
##   choose target HDL and simulator (Xilinx Xsim or ModelSim)   ##
###################################################################

#set_property target_language VHDL [current_project]
set_property target_language Verilog [current_project]

## target simulator
#set_property target_simulator ModelSim [current_project]
#set_property target_simulator IES [current_project]
#set_property target_simulator VCS [current_project]
set_property target_simulator Xsim [current_project]

## simulator language
set_property simulator_language Mixed [current_project] ;  # Verilog|VHDL|Mixed


#############################################
##   read RTL, IPs and testbench sources   ##
#############################################

#
# **NOTE
# By default, "sources_1", "constrs_1" and "sim_1" filesets are automatically created with the project
#

#create_fileset -blockset  sources_1 ;
#create_fileset -simset    sim_1
#create_fileset -constrset constrs_1

#get_filesets
#current_fileset

##
## load RTL sources
##

## use a wildcar ...
add_files -norecurse -fileset sources_1 [glob ${rtlDir}/*.v]


## or specify each single file
#add_files -norecurse -fileset sources_1 {./rtl/filename1.v}
#add_files -norecurse -fileset sources_1 {./rtl/filename2.v}
#add_files -norecurse -fileset sources_1 {./rtl/rom.mem}     <= Vivado properly recognizes ROM memory initialization files
#


##
## load testbench sources
##
add_files -norecurse -fileset sim_1 [glob ${benchDir}/*.v]


##
## load IP sources (simply load .xci files to use IPs in both simulation and implementation flows)
##

## examples :
#read_ip ${ipsDir}/PLL/PLL.xci
#add_files -norecurse -fileset sources_1 [glob ${ipsDir}/*/*.xci]
#add_files -norecurse -fileset sources_1 ${ipsDir}/ipName/ipName.xci


###################################################
##   load and parse all files into the project   ##
###################################################

import_files -force -norecurse -fileset sources_1
import_files -force -norecurse -fileset sim_1

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

## report compilation order
report_compile_order -sources -file ${workDir}/compile_order.rpt


## just for reference, by default a Vivado project is already an RTL project
set_property DESIGN_MODE RTL [current_fileset]


###############################################################
##   automated one-step compilation/elaboration/simulation   ##
###############################################################

#
# **NOTE
# Despite the one-step compilation/elebaoration/simulation flow, under the hood
# Vivado creates shell scripts for xvlog/xvhdl, xelab and xsim executables.
# Default options are fine, but if one needs to customize/extend the engines
# options can use:
#
#    set_property -name {xsim.compile.xvlog.more_options}   -value {command-line flags} -objects [get_filesets sim_1]
#    set_property -name {xsim.elaborate.xelab.more_options} -value {command-line flags} -objects [get_filesets sim_1]
#    set_property -name {xsim.simulate.xsim.more_options}   -value {command-line flags} -objects [get_filesets sim_1]
#
# or change the settings from Flows > Simulation in the GUI
#

## example xvlog options
#set_property -name {xsim.compile.xvlog.more_options} -value {--define MACRO=VALUE} -objects [get_filesets sim_1]
#set_property -name {xsim.compile.xvlog.more_options} -value {--include /path/to/include/search/directory} -objects [get_filesets sim_1]
set_property -name {xsim.compile.xvlog.more_options} -value {--incr --verbose} -objects [get_filesets sim_1]

## example xelab options
set_property -name {xsim.elaborate.xelab.more_options} -value {--debug all} -objects [get_filesets sim_1]


## compile/elaborate/simulate
launch_simulation -simset sim_1 -step all -mode behavioral -verbose

# -mode [behavioral | post-synthesis | post-implementation]
# -step [compile | elaborate | simulate | all]

report_property [current_project]
report_property [current_sim]


##########################################
##   add waveforms and run simulation   ##
##########################################

#
# **NOTE
# By default all top-level signals (testbench signals) are added to waveform window.
# Additional signals in the design hierachy (e.g. inside the module under test) must
# be explicitly added to the waveform window either from the GUI, by dragging signals
# from the "objects" window to the waveform window, or using the add_wave Tcl command
# with hiearchical signal names. Do this **BEFORE** running the simulation or after a
# reset back to time t=0 using the restart Tcl command.
#

## launch the GUI
start_gui

## optionally, probe in the script waveforms to be displayed deep in the hierarchy
#add_wave /hierarchical/path/to/signal
#add_wave /hierarchical/path/to/instance/*

## or source a dedicated probing script
#source ${scriptsDir}/probe.tcl

## run the simulation
#run 100                 ; # run the simulation for 100 ns (ns is default time unit for simulation)
#run 100 us              ; # run the simulation for 100 us (time units are ms, us, ns, fs)
run all                  ; # run the simulation till there are no more process in the design (e.g. a $finish Verilog task is encountered)


## print overall simulation time on XSim console
puts "Simulation finished at [current_time]"

## report CPU time
set tclStop [clock seconds]
set seconds [expr $tclStop - $tclStart]

puts "\nTotal elapsed-time for [info script]: [format "%.2f" [expr $seconds/60.]] minutes\n"


########################################################
##   other simulation commands (just for reference)   ##
########################################################

## reset simulation time back to t=0
#restart

## get/set current scope
#current_scope
#get_scopes
#report_scopes

## query signal values and drivers
#get_value /path/to/signal
#describe /path/to/signal
#report_values
#report_drivers /path/to/signal
#report_drivers [get_nets *signal]

## deposit a logic value on a signal
#set_value [-radix bin] /hierarchical/path/to/signal value

## force a signal
#add_force [-radix] [-repeat_every] [-cancel_after] [-quiet] [-verbose] /hierarchical/path/to/signal value
#set forceName [add_force /hierarchical/path/to/signal value]

## delete a force or all forces
#remove_forces ${forceName}
#remove_forces -all

## add/remove breakpoints to RTL sources
#add_bp fileName.v lineNumber
#remove_bp -file fileName -line lineNumber
#remove_bp -all

## unload the simulation without exiting Vivado
#close_sim

## dump Switching Activity Interchange Format (SAIF) file for power analysis
#open_saif /path/to/file.saif
#log_saif /path/to/signal
#log_saif [get_objects]
#close_saif

## hide the GUI
#stop_gui

## exit the simulator
#exit


##########################################
##   additional user-defined routines   ##
##########################################

## just an alias to restart (as used in Cadence IES simulator)
proc reset {} {
   restart
}


## custom routine to relaunch the simulation from Tcl console
proc relaunch {} {

   ## after changes to on-disk RTL sources, re-load them into Vivado project before invoking relaunch_sim
   ## ref. to https://www.xilinx.com/support/answers/56411.html
   reimport_files -force

   ## re-launch (compile/elaborate) and run the simulation
   relaunch_sim
   run all
}

