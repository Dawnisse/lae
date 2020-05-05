//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_OneHotDecoder.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 5, 2020
// [Modified]       -
// [Description]    Testbench module for 5-bit/32-bit one-hot decoder.
// [Notes]          -
// [Version]        1.0
// [Revisions]      05.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


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
