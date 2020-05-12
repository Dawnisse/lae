# Lab 6 Instructions

In this lab we start implementing **basic sequential circuits** such as **latches** and **FlipFlops**.

As a first step, open a terminal and go inside the `lab6/` directory :


```
% cd Desktop/lae/fpga/labs/lab6
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
% cp .solutions/scripts/compile.tcl   ./scripts/sim/
% cp .solutions/scripts/elaborate.tcl ./scripts/sim/
% cp .solutions/scripts/simulate.tcl  ./scripts/sim/
% cp .solutions/scripts/run.tcl       ./scripts/sim/
```

Create a first new Verilog file `rtl/DLATCH.v` and write the RTL code for a **D-latch** :


```verilog
//
// Verilog code for a simple D-latch
//


`timescale 1ns / 100ps

module DFF (

   input  wire D, EN,
   output reg Q

   ) ;


   always @(D,EN) begin

      if (EN) begin
         Q <= D ;
      end
      //else begin        // **IMPORTANT: if you don't specify the 'else' condition the tool automatically INFERS MEMORY for you !
      //   Q <= Q ;
      //end

   end  // always

endmodule
```

Create a second new Verilog file `rtl/DFF.v` and write the RTL code for a **D-FlipFlop** :

```verilog
//
// Verilog code for a simple D-FlipFlop
//

`timescale 1ns / 100ps

module DFF (

   input  wire clk,        // clock
   input  wire reset,      // reset, active-high (then can be synchronous or asynchronous)
   input  wire D,
   output reg Q

   ) ;


   always @(posedge clk) begin                     // synchronous reset
   //always @(posedge clk or posedge reset) begin      // asynchronous reset

      if (reset) begin
         Q <= 1'b0 ;
      end
      else begin
         Q <= D ;
      end
   end  // always

endmodule
```

Copy from the `.solutions/` directory the following **simulation sources** :

```
% cp .solutions/bench/glbl.v      ./bench/
% cp .solutions/bench/ClockGen.v  ./bench/
% cp .solutions/bench/tb_DFF.v    ./bench/
```

Simulate with Xilinx XSim simulator the functionality of the D-FlipFlop with :

```
% make sim
```

This `Makefile` target is equivalent to :

```
% make compile
% make elaborate
% make simulate
```

Verify the difference between **synchronous** and **asynchronous reset** by changing this lines of code

```verilog
always @(posedge clk) begin                         // synchronous reset
//always @(posedge clk or posedge reset) begin      // asynchronous reset
```

into

```verilog
//always @(posedge clk) begin                     // synchronous reset
always @(posedge clk or posedge reset) begin      // asynchronous reset
```

In order to **relaunch the simulation** after changes **without closing the XSim graphical interface** simply type

```
relaunch
```

in the XSim **Tcl console**.


## Exercise

Create a suitable testbench `bench/tb_DLATCH.v` to **simulate and verify also the functionality of the D-latch**.
