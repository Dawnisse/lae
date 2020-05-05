# Lab 4 Instructions

In this lab we implement a simple **5/32 binary to one-hot decoder** using a `for` loop statement.
We also introduce a better organization of the working area and we move the simulation under Vivado
using a **Tool Command Language (Tcl) script** in place of standalone executables.

As a first step, **open a terminal** and go inside the `lab4/` directory :

```
% cd Desktop/lae/fpga/labs/lab4
```

Copy from the `.solutions/` directory the main `Makefile` already prepared for you :


```
% cp .solutions/Makefile .
```

Explore available targets :

```
% make help
```

To create a new fresh working area, type :

```
% make area
```

Finally, copy the main **Vivado Tcl simulation script** under `scripts/` :

```
% cp .solutions/simulation.tcl ./scripts/
```


From now on, **synthesizable RTL sources** will be written inside the `rtl/`directory, while **testbench sources** inside `bench/`

Create a new Verilog file `OneHotDecoder.v` :

```
% gedit rtl/OneHotDecoder.v &   (for Linux users)
% npp rtl\OneHotDecoder.v       (for Windows users)
```

Implement the functionality of the binary to one-hot decoder using a `for` loop statement :


```verilog
`timescale 1ns / 100ps

module OneHotDecoder (

   input  wire [4:0]  Bin,      //  5-bit base-2 binary input code
   output reg  [31:0] Bout      // 32-bit one-hot output code:w

   ) ;


   integer i ;

   always @(*) begin

      for(i=0; i < 32; i=i+1) begin

         Bout[i] = (Bin[4:0] == i) ;      // this is equivalent to (Bin[4:0] == i) ? 1'b1 : 1'b0 ;

      end  // for
   end  // always

endmodule
```

Create also a suitable testbench to verify the proper functionality of the digital block :

```
% gedit bench/tb_OneHotDecoder.v &   (for Linux users)
% npp bench\tb_OneHotDecoder.v       (for Windows users
```

As an example, we can use a **5-bit counter** to generate a count fed to the decoder :

```verilog
`timescale 1ns / 100ps

module tb_OneHotDecoder ;

   /////////////////////////
   //   clock generator   //
   /////////////////////////

   parameter real PERIOD = 50.0 ;

   reg clk ;

   initial begin
      clk = 1'b0 ;
      forever #(PERIOD/2.0) clk = ~ clk ;
   end


   ///////////////////////
   //   5-bit counter   //
   ///////////////////////

   reg [4:0] count = 5'd0 ;

   always @(posedge clk)
      count <= count + 1'b1 ;


   /////////////////////////////////
   //   device under test (DUT)   //
   /////////////////////////////////

   wire [31:0] code ;

   OneHotDecoder DUT (.Bin(count[4:0]), .Bout(code[31:0]) ) ;


   //////////////////
   //   stimulus   //
   //////////////////

   initial begin

      #(64*PERIOD) $finish ;

   end

endmodule
```


Try to simulate the design using :

```
% make sim
```

## Exercise

Create a new source file `rtl/ThemometerDecoder.v`. Modify the behavioral description
of the one-hot decoder in order to implement a **5/32 binary to thermometer decoder** instead.

Reuse the previous testbench to check the proper functionality of the block.


