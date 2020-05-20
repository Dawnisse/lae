//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       PWM.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 20, 2020
// [Modified]       -
// [Description]    A simple 8-bit Pulse-Width Modulation (PWM) generator in Verilog.
//
// [Notes]          Code derived and readapted from https://www.fpga4fun.com
//
// [Version]        1.0
// [Revisions]      20.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies :
//
// n/a
//


`timescale 1ns / 100ps

module PWM (

   input  wire clk,
   input  wire [7:0] width,     // 8-bit configuration word to determine duty-cycle
   output wire pwm

   ) ;


   // 8-bit free-running counter
   reg [7:0] count = 1'b0 ;

   always @(posedge clk)
      count <= count + 1'b1 ;


   assign pwm = ( count[7:0] < width[7:0] ) ? 1'b1 : 1'b0 ;   // binary comparator (pure combinational block)

endmodule

