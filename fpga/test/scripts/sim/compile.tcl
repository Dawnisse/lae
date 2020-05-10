#
# Example custom Tcl-based simulation flow to run XSim simulation flows interactively [COMPILATION step]
#
# Luca Pacher - pacher@to.infn.it
# May 8, 2020
#

###################################################################################################
#
# **NOTE
#
# There is no "non-project mode" simulation Tcl flow in Vivado, the "non-project mode" flow
# requires to call standalone xvlog/xvhdl, xelab and xsim executables from the command-line
# or inside a GNU Makefile.
# However in "non-project mode" the simulation can't be re-invoked from the GUI after RTL
# or testbench changes, thus requiring to exit from the GUI and re-build the simulation
# from scratch. This happens because XSim doesn't keep track of xvlog/xvhdl and xelab flows.
#
# In order to be able to "relaunch" a simulation from the XSim GUI you necessarily have to
# create a project in Vivado or to use a "project mode" Tcl script to automate the simulation.
# The overhead of creating an in-memory project is low compared to the benefits of fully automated
# one-step compilation/elaboration/simulation and re-launch features.
#
# This **CUSTOM** Tcl-based simulation flow basically reproduces all compilation/elaboration/simulation
# steps that actually Vivado performs "under the hood" for you without notice in project-mode.
# Most important, this custom flow allows is **PORTABLE** across Linux/Windows systems and allows
# to "relaunch" a simulation after RTL or testbench changes from the XSim Tcl console without
# the need of creating a project.
#
# Ref. also to  https://www.edn.com/improve-fpga-project-management-test-by-eschewing-the-ide
#
###################################################################################################


## variables
set TCL_DIR  [pwd]/../../scripts ;   ## **IMPORTANT: assume to run the flow inside work/sim !
set LOG_DIR  [pwd]/../../logs
set RTL_DIR  [pwd]/../../rtl
set SIM_DIR  [pwd]/../../bench


## **WARN: all Verilog sources rtl/*.v and bench/*.v will be compiled
set RTL_SOURCES [glob ${RTL_DIR}/*.v]
set SIM_SOURCES [glob ${SIM_DIR}/*.v]


## delete previous log file if exists
if { [file exists ${LOG_DIR}/compile.log] } {

   file delete ${LOG_DIR}/compile.log
}


#############################################
##   compile all Verilog sources (xvlog)   ##
#############################################

#
# **NOTE
#
# By using the 'catch' Tcl command the compilation process will continue until the end despite SYNTAX ERRORS
# are present inside input sources. All syntax errors are then shown on the console using 'grep' on the log file.
#

puts "\n-- Parsing sources ...\n"

foreach src [concat ${RTL_SOURCES} ${SIM_SOURCES}] {

   puts "Compiling Verilog source file ${src} ..."

   ## launch the xvlog executable from Tcl
   catch {exec xvlog -relax -sv -work work ${src} -nolog | tee -a ${LOG_DIR}/compile.log}
}


#################################
##   check for syntax errors   ##
#################################

puts "\n-- Checking for syntax errors ...\n"

if { [catch {exec grep --color ERROR ${LOG_DIR}/compile.log >@stdout 2>@stdout }] } {

   puts "\t============================"
   puts "\t   NO SYNTAX ERRORS FOUND   "
   puts "\t============================"
   puts "\n"

} else {

   puts "\n"
   puts "\t=================================="
   puts "\t   COMPILATION ERRORS DETECTED !  "
   puts "\t=================================="
   puts "\n"

   puts "Please, fix all syntax errors and recompile sources.\n"
}

