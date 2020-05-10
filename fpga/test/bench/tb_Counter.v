//
// Testbench for Counter module.
//
// Luca Pacher - pacher@to.infn,it
// May 8, 2020
//


`timescale 1ns / 100ps

module tb_Counter ;


   //////////////////////////
   //    clock generator   //
   //////////////////////////

   wire clk ;

   ClockGen #(.PERIOD(100.0)) ClockGen ( .clk(clk) ) ;   // override default period as module parameter (default is 50.0 ns)


   /////////////////////////////////
   //   device under test (DUT)   //
   /////////////////////////////////

   reg reset ;

   wire [4:0] count ;

   Counter DUT ( .clk(clk), .reset(reset), .count(count[4:0]) ) ;


   //////////////////
   //   stimulus   //
   //////////////////

   initial begin

      #500 reset = 1'b1 ;
      #350 reset = 1'b0 ;

      #3000 $finish ;

   end

endmodule

