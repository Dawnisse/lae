
`timescale 1ns / 100ps

module tb_DFF ;

   /////////////////////////
   //   clock generator   //
   /////////////////////////

   wire clk, clk_buf ;

   ClockGen  #(.PEDIOD(100.0)) ClockGen (.clk(clk) ) ;   // override default period as module parameter (default is 50.0 ns)


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

   always #(20.0) D = $random ;    // use the $random Verilog task to generate a random input pattern


   initial begin

      #100  rst = 1'b0 ;   // release the reset signal
      #1500 rst = 1'b1 ;

      #300 $finish ;
   end

endmodule

