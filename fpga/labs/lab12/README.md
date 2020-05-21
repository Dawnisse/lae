# Lab 12 Instructions

In this lab we implement a **Read-Only Memory (ROM)** and we discuss the **American Standard Code for Information Interchange (ASCII) code**.

As a first step, open a terminal and go inside the `lab12/` directory :

```
% cd Desktop/lae/fpga/labs/lab12
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

Additionally, copy from the `.solutions/` directory the following **Tcl simulation scripts** :


```
% cp .solutions/scripts/sim/compile.tcl    ./scripts/sim
% cp .solutions/scripts/sim/elaborate.tcl  ./scripts/sim
% cp .solutions/scripts/sim/simulate.tcl   ./scripts/sim
% cp .solutions/scripts/sim/run.tcl        ./scripts/sim


Create the main ROM module `rtl/ROM.v` with the following content :

```verilog
`timescale 1ns / 100ps

module ROM #(parameter integer WIDTH = 8, parameter integer DEPTH = 64) (

   input  wire clk,
   input  wire en,
   input  wire [$clog2(DEPTH)-1:0] address,
   output reg [WIDTH-1:0] data

   ) ;

   (* rom_style = "block" *)                   // this is a first example of a SYNTHESIS PRAGMA, instruct the tool how to infer the ROM memory with LUTs or BRAMs
   reg [WIDTH-1:0] mem [0:DEPTH-1] ;


   ////////////////////
   //   read logic   //
   ////////////////////

   always @(posedge clk)
      if(en)
         data <= mem[address] ;


   ////////////////////////////
   //   ROM initialization   //
   ////////////////////////////

   initial begin

      // initialize the ROM using an external file
      $readmemh("../../rtl/ROM.hex", mem) ;

   end

endmodule
```

Copy from the `.solutions/` directory the sample **ROM hex initialization file** :

```
% cp .solutions/rtl/ROM.hex ./rtl
```

Copy remaining RTL and simulation sources from the `.solutions/` directory as follows :


```
% cp .solutions/rtl/TickCounter.v  ./rtl
% cp .solutions/bench/ClockGen.v   ./bench
% cp .solutions/bench/tb_ROM.v     ./bench
```

Compile, elaborate and simulate the design with :

```
% make compile
% make elaborate
% make simulate
```

or simply type

```
% make sim
```

Verify if the stream of ASCII characters read from the ROM is the expected one.

