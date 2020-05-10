rem #
rem # Sample login script for Microsoft Windows command line
rem #
rem # Luca Pacher - pacher@to.infn.it
rem # Spring 2020
rem #

:: turn off commands echoing
@echo off

echo.
echo Loading %USERPROFILE%\login.bat
echo.


rem #######################
rem #   Notepad++ setup   #
rem #######################

:: include Notepad++ executable to system search path
set PATH=C:\where\you\installed\Notepad++;%PATH%

:: create a shorter alias for notepad++.exe for faster typing
doskey npp=notepad++.exe $*


rem ###########################
rem #   Xilinx Vivado setup   #
rem ###########################

:: variable to locate the main Xilinx Vivado installation directory, e.g. C:\Xilinx
set XILINX_DIR=C:\Xilinx

:: add Vivado executables to system search path
call %XILINX_DIR%\Vivado\<version>\settings64.bat


rem #########################
rem #   Linux executables   #
rem #########################

:: add Linux executables from Git for Windows to search path
set PATH=C:\where\you\installed\Git\cmd;C:\where\you\installed\Git\usr\bin;%PATH%

:: force the Command Prompt to search built-in executables in PATH (https://superuser.com/questions/1253369/gnuwin32-makefile-mkdir-p)
doskey mkdir="mkdir.exe" $*
doskey echo="echo.exe" $*
doskey more="more.exe" $*

:: a few useful aliases for ls commands
doskey ls=ls --color $*
doskey ll=ls -lah $*


rem ###################
rem #   Tclsh setup   #
rem ###################

:: add WinTclTk executables to search path
set PATH=C:\where\you\installed\WinTclTk\bin;%PATH%

:: rename default executable tclsh85.exe as tclsh
::doskey tclsh=tclsh85.exe $* 


rem ######################################
rem #   Additional user customizations   #
rem ######################################

:: create a doskey to start a new cmd.exe instance from current directory (using %%VAR%% in doskey prevents value replacement)
doskey hterm=start /d %%cd%% cmd.exe /k "title %%cd%% & call %%USERPROFILE%%\login.bat"

