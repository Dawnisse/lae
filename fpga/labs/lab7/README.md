# Lab 7 Instructions

In this lab we simulate and implement on FPGA a simple **8-bit shift register**.

As a first step, open a terminal and go inside the `lab6/` directory :


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

Copy from the `.solutions/` directory all **Tcl simulation scripts** as follows :

```
% cp .solutions/scripts/sim/compile.tcl   ./scripts/sim/
% cp .solutions/scripts/sim/elaborate.tcl ./scripts/sim/
% cp .solutions/scripts/sim/simulate.tcl  ./scripts/sim/
% cp .solutions/scripts/sim/run.tcl       ./scripts/sim/
```

Additionally, copy from the `.solutions/` directory the following **Vivado Tcl script** :

```
% cp .solutions/scripts/common/project.tcl ./scripts/common/
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

   // assign the MSB to serial-out
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
