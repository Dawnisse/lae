#
# sample Makefile to test tools installation
#

## default target
default : help


## parse and compile Verilog sources
compile :

	@xvlog test.v
	

## elaborate and launch simulation
sim : xsim.dir/work

	@xelab -debug all test
	@xsim -gui test -tclbatch run.tcl


## delete log files and temporary files
clean :

	@rm -f *.log *.jou *.wdb *.pb *.str
	@rm -rf *.dir .Xil



## command line help 
help :

	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@echo ""
	@echo " - make help      Command-line help"
	@echo " - make compile   Parse and compile Verilog sources"
	@echo " - make sim       Run simulation"
	@echo " - make clean     Delete all log files and temporary files"
	@echo ""

