//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       DFF.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 11, 2020
// [Modified]       -
// [Description]    Verilog code for a simple D-FlipFlop.
// [Notes]          -
// [Version]        1.0
// [Revisions]      11.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module DFF (

   input  wire clk,        // clock
   input  wire reset,      // reset, active-high (then can be synchronous or asynchronous according to sensitivity list)
   input  wire D,
   output reg Q

   ) ;


   //always @(posedge clk) begin                     // synchronous reset
   always @(posedge clk or posedge reset) begin      // asynchronous reset

      if (reset) begin
         Q <= 1'b0 ;            // inside clocked always blocks use a NON-BLOCKING assignment <= instead of a BLOCKING assignment =
      end
      else begin
         Q <= D ;
      end
   end  // always

endmodule

