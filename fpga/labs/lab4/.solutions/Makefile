
############################
##   working area setup   ##
############################

## main "scratch" working area used to run the flows
WORK_DIR := work

## additional useful "clean" directories to store design data
RTL_DIR := rtl
SIM_DIR := bench
TCL_DIR := scripts
XDC_DIR := xdc
IPS_DIR := cores

## extra directories
TEMP_DIR := tmp
TEST_DIR := test

## some useful UNIX aliases
ECHO  := echo -e
RM    := rm -f -v
RMDIR := rm -rf -v
MKDIR := mkdir -p -v


## by default, run in GUI mode
mode ?= gui
#mode=tcl


## by default call Makefile help
.PHONY : default
default : help


## creates a new fresh working area with all necessary directories used in the flows
area :
	@$(MKDIR) $(RTL_DIR)
	@$(MKDIR) $(SIM_DIR)
	@$(MKDIR) $(TCL_DIR)
	@$(MKDIR) $(IPS_DIR)
	@$(MKDIR) $(XDC_DIR)

	@$(MKDIR) $(WORK_DIR)/sim
	@$(MKDIR) $(WORK_DIR)/impl

	@$(MKDIR) $(TEMP_DIR)
	@$(MKDIR) $(TEST_DIR)

	@$(ECHO) "\n-- Working area setup completed !\n\n"


## one-step compilation, elaboration and simulation within Vivado
sim :
	@vivado -mode $(mode) -source $(TCL_DIR)/simulation.tcl -log $(LOG_DIR)/simulation.log -nojournal -verbose -notrace



## clean the working area
.PHONY : clean
clean :
	@$(RMDIR) $(WORK_DIR)/sim/*


## command line help
.PHONY : help
help :

	@$(ECHO) ""
	@$(ECHO) "Usage: make <target> [mode=gui|tcl]"
	@$(ECHO) ""
	@$(ECHO) "Available targets:"
	@$(ECHO) ""
	@$(ECHO) " - make help      Command-line help"
	@$(ECHO) " - make area      Creates new fresh working area"
	@$(ECHO) " - make sim       One-step compilation, elaboration and simulation within Vivado"
	@$(ECHO) " - make clean     Delete all log files and temporary files"
	@$(ECHO) ""

