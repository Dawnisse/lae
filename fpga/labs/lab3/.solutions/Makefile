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

