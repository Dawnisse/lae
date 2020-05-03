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


## by default call Makefile help
.PHONY : default
default : help

## compile Verilog sources
.PHONY : compile
compile :
	@xvlog $(SOURCES) -log compile.log

## elaborate the design and invoke the simulator
.PHONY : sim
sim :
	@xelab -debug all $(TOP) -log elaborate.log
	@xsim -gui -tclbatch run.tcl $(TOP) -log simulate.log

## clean the working area
.PHONY : clean
clean :
	@$(RMDIR) xsim.dir .Xil
	@$(RM) *.log *.jou *.pb *.wdb

## command line help 
.PHONY : help
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
