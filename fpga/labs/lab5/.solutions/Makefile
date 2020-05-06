#######################################
##   preamble (reserved variables)   ##
#######################################

## 'make' extra flags
MAKEFLAGS += --warn-undefined-variables --debug

## Bash configuration (be picky and exit immediately on any error)
SHELL := bash
.SHELLFLAGS := -e -u -o pipefail -c


############################
##   working area setup   ##
############################

## main "scratch" working area used to run the flows
WORK_DIR := work

## additional useful "clean" directories to store design data
RTL_DIR := rtl
SIM_DIR := bench
TCL_DIR := scripts
IPS_DIR := cores
XDC_DIR := xdc
LOG_DIR := logs


## extra directories
TEMP_DIR := tmp
TEST_DIR := test

## some useful UNIX aliases
ECHO  := echo -e
RM    := rm -f -v
RMDIR := rm -rf -v
MKDIR := mkdir -p -v


## by default, run in Tcl mode (faster, then call start_gui from Tcl scripts when GUI is needed)
mode ?= tcl
#mode=gui


## by default call Makefile help
.PHONY : default
default : help


## creates a new fresh working area with all necessary directories used in the flows
.PHONY : area
area :

	@$(MKDIR) $(RTL_DIR)
	@$(MKDIR) $(SIM_DIR)
	@$(MKDIR) $(TCL_DIR)
	@$(MKDIR) $(IPS_DIR)
	@$(MKDIR) $(XDC_DIR)
	@$(MKDIR) $(LOG_DIR)

	@$(MKDIR) $(WORK_DIR)/sim
	@$(MKDIR) $(WORK_DIR)/impl

	@$(MKDIR) $(TEMP_DIR)
	@$(MKDIR) $(TEST_DIR)

	@$(ECHO) "\n   -- Working area setup completed !\n\n"


## one-step compilation, elaboration and simulation within Vivado
.PHONY : simulation sim
simulation :
	@vivado -mode $(mode) -source $(TCL_DIR)/$@.tcl -log $(LOG_DIR)/$@.log -nojournal -verbose -notrace

sim : simulation


## create fresh Vivado project attached to Arty7 device
.PHONY : project
project :
	@vivado -mode $(mode) -source $(TCL_DIR)/$@.tcl -log $(LOG_DIR)/$@.log -nojournal -verbose -notrace


## clean the working area
.PHONY : clean
clean :

	@$(RM) *.log *.jou *.pb *.wdb $(LOG_DIR)/*
	@$(RMDIR) .Xil xsim.dir
	@$(RMDIR) $(WORK_DIR)/sim/*


## command line help
.PHONY : help
help :

	@$(ECHO) "\nUsage: make <target> [mode=gui|tcl]\n\n"
	@$(ECHO) "Available targets:\n"
	@$(ECHO) " - make help      Command-line help"
	@$(ECHO) " - make area      Creates new fresh working area"
	@$(ECHO) " - make project   Creates new fresh project attached to Arty7 device"
	@$(ECHO) " - make sim       One-step compilation, elaboration and simulation within Vivado"
	@$(ECHO) " - make clean     Delete all log files and temporary files\n"

