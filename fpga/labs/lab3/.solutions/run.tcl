#
# Example Tcl simulation script for Xilinx XSim simulator
#

## profiling
set tclStart [clock seconds]

## add all top-level signals to the Wave window
add_wave /*

## run the simulation
run all

## print overall simulation time on XSim console
puts "Simulation finished at [current_time]"

## report CPU time
set tclStop [clock seconds]
set seconds [expr $tclStop - $tclStart]

puts "\nTotal elapsed-time for [info script]: [format "%.2f" [expr $seconds/60.]] minutes\n"

