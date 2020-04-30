#
# Makefile example to automate the simulation flow
#

## list of Verilog sources to be compiled
SOURCES := MUX.v tb_MUX.v

## top-level module (testbench)
TOP := tb_MUX

## some useful Linux aliases
RM := rm -f -v
RMDIR := rm -rf -v


default : help

## compile Verilog sources
compile :
	@xvlog $(SOURCES)

## elaborate the design and invoke the simulator
sim :
	@xelab -debug all $(TOP)
	@xsim -gui -tclbatch run.tcl $(TOP)

## clean the working area
clean :
	@$(RM) *.log *.jou *.pb *.wdb *.wcfg
	@$(RMDIR) xsim.dir .Xil

## command line help 
help :

	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@echo ""
	@echo " - make help      Command-line help"
	@echo " - make compile   Parse and compile Verilog sources"
	@echo " - make sim       Elaborate the design and launch the simulation"
	@echo " - make clean     Delete all log files and temporary files"
	@echo ""
