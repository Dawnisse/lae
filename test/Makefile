#
# sample Makefile to test tools installation
#

## parse and compile Verilog sources
compile :

	@xvlog test.v
	
## elaborate and launch simulation
sim :

	@xelab -debug all test
	@xsim -gui test -tclbatch run.tcl


## delete log files and temporary files
clean :

	@rm -f *.log *.jou *.wdb *.pb *.str
	@rm -rf *.dir .Xil
