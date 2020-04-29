
:: delete all log files and simulation outputs

@echo off

del /F /Q *.log *.jou *pb *.wdb > nul

rmdir /S /Q xsim.dir .Xil > nul

