//
// Sample Verilog code for a 5-bit counter with synchronous reset
// to test Xilinx tools installation. The RTL also contains Xilinx
// primitives for test purposes.
//
// Luca Pacher - pacher@to.infn,it
// May 8, 2020
//


`timescale 1ns / 100ps

module Counter (

   input  wire clk,
   input  wire reset,
   output reg [4:0] count

   ) ;


   ////////////////////////////////////////////////////////////////
   //   pre-place BUFFERS on input signals (Xilinx primitives)   //
   ////////////////////////////////////////////////////////////////

   // internal signals
   wire clk_int, reset_int ;

   IBUF IBUF_clk_inst ( .I(clk), .O(clk_int) ) ;             // require glbl.v to be compiled and elaborated along with other sources
   IBUF IBUF_reset_inst ( .I(reset), .O(reset_int) ) ;


   ///////////////////////
   //   5-bit counter   //
   ///////////////////////

   always @(posedge clk_int) begin

      if(reset_int) begin
         count <= 5'b00000 ;
      end

      else begin
         count <= count + 1'b1 ;
      end

   end  // always

endmodule

