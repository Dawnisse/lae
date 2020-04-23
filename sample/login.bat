:: sample login script for Windows Batch Command Prompt

@echo off

echo.
echo Loading %USERPROFILE%\login.bat
echo.


:: include Notepad++ executable to search path
set PATH=\path\to\Notepad++\installation\directory;%PATH%


:: create a shorter alias for notepad++.exe for faster typing
doskey npp=notepad++.exe $*


:: variable to locate the main Xilinx Vivado installation directory
set VIVADO_DIR=C:\Xilinx


:: add Vivado executables to search path
call %VIVADO_DIR%\Vivado\2019.2\settings64.bat


:: add GNU Win executables to search path
set PATH=%VIVADO_DIR%\SDK\2019.2\gnuwin\bin;%PATH%
