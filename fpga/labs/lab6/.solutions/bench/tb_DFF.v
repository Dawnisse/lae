//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_DFF.v [TESTBENCH]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 11, 2020
// [Modified]       -
// [Description]    Testbench module for DFF.
// [Notes]          -
// [Version]        1.0
// [Revisions]      11.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module tb_DFF ;

   /////////////////////////
   //   clock generator   //
   /////////////////////////

   wire clk, clk_buf ;

   ClockGen  #(.PERIOD(100.0)) ClockGen_inst (.clk(clk) ) ;   // override default period as module parameter (default is 50.0 ns)


   ////////////////////////////////////////////////
   //   example Xilinx primitive instantiation   //
   ////////////////////////////////////////////////

   IBUF IBUF_inst ( .I(clk), .O(clk_buf) ) ;


   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg D = 1'b1 ;
   reg rst = 1'b1 ;

   wire Q ;

   DFF DUT (.clk(clk_buf), .reset(rst), .D(D), .Q(Q) ) ;


   //////////////////
   //   stimulus   //
   //////////////////

   // use the $random Verilog task to generate a random input pattern
   always #(20.0) D = $random ;             // **WARN: $random returns a 32-bit integer ! Here there is an implicit TYPE CASTING

   initial begin

      #100  rst = 1'b0 ;   // release the reset signal
      #1500 rst = 1'b1 ;

      #300 $finish ;   // stop the simulation
   end

endmodule

