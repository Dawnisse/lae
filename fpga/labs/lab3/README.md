# Lab 3 Instructions

In this lab we introduce a certain number of **new Verilog constructs** and we discuss different **coding styles** in HDL.<br/>
The digital block used for this purpose is a simple **2-inputs multiplexer**.

As a first step, **open a terminal** and go inside the `lab3/` directory :

```
% cd Desktop/lae/fpga/labs/lab3
```


Simulation **scripts** such as `Makefile` and `run.tcl` and the **testbench module**
can be **copied** from the `.solutions/` directory using `cp` :

```
% cp .solutions/Makefile .
% cp .solutions/run.tcl .
% cp .solutions/tb_MUX.v .
```

Create a new Verilog file `MUX.v` :

```
% gedit MUX.v &   (for Linux users)
% npp MUX.v       (for Windows users)
```


The main module declaration is the following :

```verilog
`timescale 1ns / 100ps

module MUX (

   input  wire A, B, S,
   //output wire Z             // Z must be declared as 'wire' if assigned through 'assign' or gate primitives, otherwise
   output reg Z                // the net type must be 'reg' if Z is used within a procedural block such as 'always' 

   ) ;



endmodule
```

A first possible implementation for the multiplexer is using a **behavioural description** with
a software-like `if/else` statement inside an `always` procedural block :

```verilog

////////////////////////////////
//   behavioral description   //
////////////////////////////////

always @(A,B,S) begin          // **IMPORTANT: this is a COMBINATIONAL block, all signals contribute to the SENSITIVITY LIST

   if( S == 1'b0 ) begin       // **NOTE: the C-style equality operator checks if the condition is true or false
      Z = A ;
   end
   else begin
      Z = B ;
   end
end   // always
```

Another possibility is to use a more compact **conditional assignment** as derived
from the native C programming language (conditional operator) :


```verilog
////////////////////////////////
//   conditional assignment   //
////////////////////////////////

assign Z = (S == 1'b0) ? A : B ;        // this is equivalent to assign Z = (~S) ? A : B ;
```

We can also use a `case` statement and write the **truth table** of the combinational block :


```verilog
/////////////////////
//   truth table   //
/////////////////////

always @(A,B,S) begin

   case( {S,A,B} )

      3'b000 : Z = 1'b0 ;  // A
      3'b001 : Z = 1'b0 ;  // A
      3'b010 : Z = 1'b1 ;  // A
      3'b011 : Z = 1'b1 ;  // A
      3'b100 : Z = 1'b0 ;  // B
      3'b101 : Z = 1'b1 ;  // B
      3'b110 : Z = 1'b0 ;  // B
      3'b111 : Z = 1'b1 ;  // B

   endcase
end   // always
```


A forth possibility is to explicitly write the **logic equation** as it can be derived from the **truth table** :


```verilog
//////////////////////////
//   boolean function   //
//////////////////////////

assign Z = (A & ~S) | (B & S) ;
```

Finally, we can also implement the block at **schematic level** using **gates primitives** :


```verilog
//////////////////////////////////////////
//   schematic using gates primitives   //
//////////////////////////////////////////

wire w1, w2, Sbar ;

not u1 (Sbar, S) ;

and u2 (w1, A, Sbar) ;
and u2 (w2, B, S) ;

or  u3 (Z, w1, w2) ;
```

Try to **simulate all possible different implementations** and **verify the expected functionality** of a 2:1 multiplexer.<br/>
Use the `Makefile` to automate the simulation flow :

```
% make compile
% make sim
```



