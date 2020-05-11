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


   //always @(posedge clk) begin                     // synchronous reset
   always @(posedge clk or posedge reset) begin      // asynchronous reset

      if (reset) begin
         Q <= 1'b0 ;
      end
      else begin
         Q <= D ;
      end
   end  // always

endmodule

