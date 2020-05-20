//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       LFSR.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 20, 2020
// [Modified]       -
// [Description]    Simple Pseudo-Random Bit Sequence (PRBS) generator using a Linear Feedback
//                  Shift Register (LFSR).
//
// [Notes]          Code derived and readapted from https://www.fpga4fun.com
//
// [Version]        1.0
// [Revisions]      20.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies :
//
// rtl/TickCounter.v
//


`timescale 1ns / 100ps

module LFSR (

   input  wire clk,      // assume 100 MHz input clock fed to "ticker"
   output wire PRBS      // output pseudo-random bit sequence

   ) ;


   /////////////////////////
   //   10 MHz "ticker"   //
   /////////////////////////

   wire enable ;

   TickCounter #(.MAX(10)) TickCounter_inst (.clk(clk), .tick(enable)) ;


   /////////////////////////////////////////
   //   linear feedback shift register   //
   /////////////////////////////////////////

   // seed
   reg [7:0] LFSR = 8'hFF ;       // what happens if we put 8'h00 ?


   wire feedback = LFSR[7] ;

   //wire feedback = LFSR[7] ^ (LFSR[6:0] == 7'b0000000) ;  // this modified feedback allows reaching 256 states instead of 255


   always @(posedge clk) begin

      if (enable) begin

         LFSR[0] <= feedback ;
         LFSR[1] <= LFSR[0] ;
         LFSR[2] <= LFSR[1] ^ feedback ; 
         LFSR[3] <= LFSR[2] ^ feedback ;
         LFSR[4] <= LFSR[3] ^ feedback ;
         LFSR[5] <= LFSR[4] ;
         LFSR[6] <= LFSR[5] ;
         LFSR[7] <= LFSR[6] ;

      end   // if
   end // always

   assign PRBS = LFSR[7] ;

endmodule

