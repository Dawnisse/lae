# Lab 7 Instructions

In this lab we simulate and implement on FPGA a simple **8-bit shift register**.

As a first step, open a terminal and go inside the `lab7/` directory :


```
% cd Desktop/lae/fpga/labs/lab7
```

Copy from the `.solutions/` directory the main `Makefile` already prepared for you :

```
% cp .solutions/Makefile .
```

Explore available targets :

```
% make help
```

Create a new fresh working area :

```
% make area
```

Copy from the `.solutions/` the main Vivado initialization script :

```
% cp .solutions/scripts/common/init.tcl ./scripts/common/
```


## Design entry and RTL simulation

Copy from the `.solutions/` directory all **Tcl simulation scripts** as follows :

```
% cp .solutions/scripts/sim/compile.tcl   ./scripts/sim/
% cp .solutions/scripts/sim/elaborate.tcl ./scripts/sim/
% cp .solutions/scripts/sim/simulate.tcl  ./scripts/sim/
% cp .solutions/scripts/sim/run.tcl       ./scripts/sim/
```

Create a new Verilog file `rtl/ShiftRegister.v` and write the following RTL code :

```verilog
//
// Verilog code for a simple 8-bit shift-left register with positive-edge clock,
// asynchronous parallel load, serial-in, and serial-out.
//


`timescale 1ns / 100ps

module ShiftRegister #(parameter [7:0] INIT = 8'h00) (

   input  wire clk,
   input  wire SI,                  // serial-in
   input  wire [7:0] PDATA,         // 8-bit parallel-data
   input  wire LOAD,                // load 1, shift 0
   output wire SO                   // serial-out

   ) ;



   // startup value
   reg [7:0] q = INIT ;            // this works also on FPGA thanks to Global Set/Reset (GSR) when firmware is downloaded !

   always @(posedge clk) begin

      // load mode
      if(LOAD) begin

         q <= PDATA ;
      end

      // shift-mode otherwise
      else begin

         q[7:0] <= { q[6:0] , SI } ;     // shift-left using concatenation

      end   // if
   end   // always

   // assign the MSB to serial-output
   assign SO = q[7] ;

endmodule
```

Copy from the `.solutions/` directory the following **simulation sources** :

```
% cp .solutions/bench/glbl.v               ./bench/
% cp .solutions/bench/ClockGen.v           ./bench/
% cp .solutions/bench/tb_ShiftRegister.v   ./bench/
```

Simulate with Xilinx XSim simulator the functionality of the shift-register with :

```
% make sim
```

This `Makefile` target is equivalent to :

```
% make compile
% make elaborate
% make simulate
```


## FPGA implementation flow - GUI mode

Copy from the `.solutions/` directory the following **Vivado Tcl script** :

```
% cp .solutions/scripts/common/project.tcl ./scripts/common/
```

Additionally, copy the **constraints file** containing **ports assignments and timing constraints**
for the FPGA implementation flow :

```
% cp .solutions/xdc/ShiftRegister.xdc ./xdc
```

Create a new **Vivado project** attached to the Arty7 device with :

```
% make project mode=gui
```

Using the **Add Sources** menu entry in the  **Flow navigator** load **the main RTL Verilog file** (*Add or create design sources*),
all **testbench sources** (*Add or create simulation sources*) and the **XDC file** (*Add or create constraints*) in the newly created
project and try to run from the GUI **all steps of the FPGA implementation flow** :

* behavioral simulation
* generic synthesis (RTL elaboration)
* mapped synthesis
* post-synthesis functional simulation
* post-synthesis timing simulation
* place-and-route (implementation)
* post-implementation functional simulation
* post-implementation timing simulation
* bitstream generation


## FPGA implementation flow - batch mode

The same implementation flow available from the GUI can be **scripted** and launched in **batch mode** to reduce the runtime.

Sample Tcl scripts can be found in the `.solutions/scripts/impl` directory. Copy all scripts as follows :

```
% cp .solutions/scripts/impl/xflow.tcl   ./scripts/impl/
% cp .solutions/scripts/impl/upload.tcl  ./scripts/impl/
% cp .solutions/scripts/impl/flash.tcl   ./scripts/impl/
```

Explore the content of these Tcl scripts. Try to implement the `ShiftRegister` design in batch mode with :

```
% make bit
```


## Compile a Phase-Locked Loop (PLL) IP core to increase the clock frequency

Compile a new **Phase-Locked Loop (PLL)** core using the **Vivado IP flow** in order to **synthesize a 200 MHz clock** starting from the
available **on-board 100 MHz clock**.

As a first step copy from the `.solutions/` directory the following Tcl script :

```
% cp .solutions/scripts/common/ip.tcl ./scripts/common/
```

Launch the **Vivado IP flow** with :

```
% make ip
```

Select in the **IP Catalog** the **Clocking Wizard** available under *Cores > FPGA Features and Design > Clocking > Clocking Wizard*.
Right click on **Clocking Wizard** and select **Customize IP...**.

Create a new IP core named `PLL` with the following features :

* 100 MHz input clock
* 200 MHz output clock
* no reset signal

Change default port names in order to have `CLK100`, `CLK200` and `LOCKED`.

Compile the IP and **generate all output products**. Additionally, **export all simulation scripts** by executing in the Tcl console
the following custom Tcl procedure :

```
export_xsim_scripts
```

Inspect source files automatically generated for you in the `cores/PLL` and `cores/export_scripts` directories.

Most important files for our purposes are :

* the main **Xilinx Core Instance (XCI)** XML file `*.xci` containing the IP configuration
* the Verilog instantiation template `*.veo`
* the XDC constraints file for the IP core `*.xdc`
* a self-contained gate-level Verilog netlist `*_netlist.v` for simulations

<hr>

**IMPORTANT**

The  **Xilinx Core Instance (XCI)** XML file containing the configuration of the IP allows to
easily re-compile from scratch the IP core.

<hr>


Modify the original testbench `bench/tb_ShiftRegister.v` and instantiate the newly created PLL core :

```verilog

wire clk_200, pll_locked ;

PLL PLL_inst ( .CLK100(clk), .CLK200(clk_200), .LOCKED(pll_locked) ) ;
```

Connect the 200 MHz clock generated by the PLL to the shift-register :

```verilog
ShiftRegister  DUT ( .clk(clk_200), .LOAD(shift0_load1), .PDATA(data), .SI(1'b0), .SO(serial_out)) ;
```



Additionally, modify the stimulus and **wait for the PLL to lock** before de-asserting the `shift0_load1l`control signal for the shift-register :

```verilog
initial begin

   #0   shift0_load1 = 1'b1 ; data = 8'b1010_1011 ;    // this is equivalent to 8'hAB

   @(posedge pll_locked)           // wait for the PLL to lock

   #420 shift0_load1 = 1'b0 ;

   #(8*100.0)

   #100 $finish ;
end
```


Resimulate the design :

```
% make sim
```

## Further readings

If you are interested in more in-depth details about the Xilinx Vivado **Clocking Wizard**, please ref. to :

* [*Clocking Wizard v6.0 LogiCORE IP Product Guide*](https://www.xilinx.com/support/documentation/ip_documentation/clk_wiz/v6_0/pg065-clk-wiz.pdf)

