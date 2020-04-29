#
# A first simple Makefile example to automate the simulation flow
#

SOURCES := Gates.v tb_Gates.v
TOP := tb_Gates

## compile Verilog sources
compile :
	@xvlog $(SOURCES)

## elaborate the design and invoke the simulator
sim :
	@xelab -debug all $(TOP)
	@xsim -gui -tclbatch run.tcl $(TOP)

## clean the working area
clean :
	@source clanup.sh   (for Linux users)
	@call cleanup.bat   (for Windows users)
