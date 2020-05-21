//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_LFSR.v [TESTBENCH]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 20, 2020
// [Modified]       -
// [Description]    Testbench module for Pseudo-Random Bit Sequence (PRBS) generator using a Linear
//                  Feedback Shift Register (LFSR).
// [Notes]          -
// [Version]        1.0
// [Revisions]      20.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies :
//
// rtl/LFSR.v
// bench/ClockGen.v
//


`timescale 1ns / 100ps

module tb_LFSR ;


   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk ;

   ClockGen ClockGen_inst ( .clk(clk) ) ;


   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   wire PRBS ;

   LFSR  DUT (.clk(clk), .PRBS(PRBS) ) ;


   //////////////////
   //   stimulus   //
   //////////////////

   integer f ;    // the $fopen Verilog task returns a 32-bit integer

   initial begin

      f = $fopen("bytes.txt") ;      // open the file handler

      #(8*100*1000) $fclose(f) ; $finish ;   // simply run for some time and observe the pseudo-random output bit pattern
   end


   always @(posedge DUT.enable) begin      // register pseudo-random bit values to ASCII file whenever a "tick" is asserted inside the LFSR

      $fdisplay(f,"%d", DUT.LFSR[7:0]) ;
   end

endmodule

