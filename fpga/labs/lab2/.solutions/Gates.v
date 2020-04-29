//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       Gates.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        Apr 28, 2020
// [Modified]       -
// [Description]    Describe basic logic gates in Verilog using continuous assignments.
// [Notes]          -
// [Version]        1.0
// [Revisions]      28.04.2020 - Created
//-----------------------------------------------------------------------------------------------------


//
// Available Verilog basic bit-wise logic operators are  :
// 
// NOT  ~
// AND  &
// OR   |
// XOR  ^
//


`timescale 1ns / 100ps

module Gates (

   input  wire A,
   input  wire B,
   output wire [5:0] Z    // note that Z is a 6-bit width output BUS

   ) ;

   // AND
   assign Z[0] = A & B ;

   // NAND
   assign Z[1] = ~(A & B) ;

   // OR
   assign Z[2] = A | B ;

   // NOR
   assign Z[3] = ~(A | B) ;

   // XOR
   assign Z[4] = A ^ B ;

   // XNOR
   assign Z[5] = ~(A ^ B) ;


endmodule

