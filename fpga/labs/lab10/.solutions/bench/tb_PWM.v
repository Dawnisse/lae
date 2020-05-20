//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_PWM.v [TESTBENCH]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 20, 2020
// [Modified]       -
// [Description]    Simple testbench module for an 8-bit Pulse-Width Modulation (PWM) generator.
// [Notes]          -
// [Version]        1.0
// [Revisions]      20.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies :
//
// rtl/PWM.v
//


`timescale 1ns / 100ps

module tb_PWM ;


   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk100 ;

   ClockGen ClockGen_inst ( .clk(clk100) ) ;



   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg [7:0] width ;

   wire pwm_out ;

   PWM  DUT ( .clk(clk100), .width(width[7:0]), .pwm(pwm_out) ) ;


   //////////////////
   //   stimulus   //
   //////////////////

   initial begin

      // explore 4 periods for each configuration 

      #0          width = 8'h0A ;      //  10
      #(4*256*10) width = 8'hA0 ;      // 160
      #(4*256*10) width = 8'h6D ;      // 109
      #(4*256*10) width = 8'hFF ;      // 255
      #(4*256*10) width = 8'h00 ;      //   0

      #(4*256*10) $finish ;

   end

endmodule

