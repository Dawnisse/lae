# Lab 9 Instructions

In this lab we design and simulate a **parameterizable N-digit Binary Coded Decimal (BCD) counter**. We also introduce the new
`gennerate` for-loop construct to replicate a certain module or primitive an arbitrary number of times.


As a first step, open a terminal and go inside the `lab9/` directory :

```
% cd Desktop/lae/fpga/labs/lab9
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
```

Create a first new Verilog source `rtl/BCD_counter_en.v` with the following content :


```verilog
`timescale 1ns / 100ps

module BCD_counter_en (

   input  wire clk,
   input  wire rst,
   input  wire  en,
   output reg [3:0] BCD,
   output wire carryout 

   ) ;
   

   always @(posedge clk) begin                              // synchronous reset
   //always @(posedge clk or posedge rst) begin 	    // asynchronous reset

      if( rst == 1'b1 )
         BCD <= 4'b0000 ;

      else begin

         if( en == 1'b1 ) begin      // let the counter to increment only if enabled !

            if( BCD == 4'b1001 )     // force the count roll-over at 9
               BCD <= 4'b0000 ;
            else
               BCD <= BCD + 1 ;
         end

      end
   end // always


   assign carryout = ( (BCD == 4'b1001) && (en == 1'b1) ) ? 1'b1 : 1'b0 ;

endmodule
```

Create also a second Verilog source `rtl/BCD_counter_Ndigit.v` with the following content :

```verilog
`timescale 1ns / 100ps

module BCD_counter_Ndigit #(parameter integer Ndigit = 3) (

   input   wire clk,
   input   wire rst,
   input   wire en,
   output  wire [Ndigit*4-1:0] BCD

   ) ;


   wire [Ndigit:0] carry ;   // roll-over flags

   assign carry[0] = en ;

   generate

      genvar k ;

      for(k = 0; k < Ndigit; k = k+1) begin : digit  

         BCD_counter_en   digit (

            .clk      (             clk ),
            .rst      (             rst ),
            .en       (        carry[k] ),
            .BCD      (  BCD[4*k+3:4*k] ),
            .carryout (      carry[k+1] )

         ) ;

      end // for

   endgenerate

endmodule
```


Simulation sources have been already prepared for you, copy from the `.solutions/` directory the following **testbench sources** :


```
% cp .solutions/bench/ClockGen.v               ./bench
% cp .solutions/bench/tb_BCD_counter_Ndigit.v  ./bench
```


Compile, elaborate and simulate this small design with :

```
% make compile
% make elaborate
% make simulate
```

or simply type

```
% make sim
```


## Exercise

Modify the testbench in order to count once every 1us **without changing the main 100 MHz clock frequency**.
Create a new **"ticker" module** using an additional **free-running counter** to generate a count-enable "tick" every 1 us instead.


## Extra code

The complete code for a 3-bit BCD counter driving a **7-segment display device** is also part of RTL solutions.

Inspect the content of `.solutions/rtl/seven_seg_decoder.v` and `.solutions/rtl/Ndigit_7seg_display.v` Verilog sources and try to understand
the structure of the overall design.

