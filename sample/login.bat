::
:: sample login script for Microsoft Windows command line
::

:: turn off commands echoing
@echo off

echo.
echo Loading %USERPROFILE%\login.bat
echo.


:: include Notepad++ executable to system search path
set PATH=C:\where\you\installed\Notepad++;%PATH%


:: create a shorter alias for notepad++.exe for faster typing
doskey npp=notepad++.exe $*


:: variable to locate the main Xilinx Vivado installation directory, e.g. C:\Xilinx
set XILINX_DIR=C:\Xilinx


:: add Vivado executables to system search path
call %XILINX_DIR%\Vivado\<version>\settings64.bat


:: add WinBash executables to search path
set PATH=C:\where\you\installed\WinBash\bin;%PATH%


:: add here additional user customizations
