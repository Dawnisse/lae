//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       BCD_counter_Ndigit.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 19, 2020
// [Modified]       -
// [Description]    Parameterized N-digit BCD counter. The logic includes an end-of-scale flag
//                  asserted when 9999 ... 9 is reached and an overflow flag when the count goes
//                  out of range.
// [Notes]          -
// [Version]        1.0
// [Revisions]      19.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies:
//
// rtl/BCD_counter_en.v
//


`timescale 1ns / 100ps

module BCD_counter_Ndigit #(parameter integer Ndigit = 3) (

   input  wire clk,
   input  wire rst,
   input  wire en,
   output wire [Ndigit*4-1:0] BCD,
   output wire overflow,               // asserted when the most-significant digit generates a carry
   output wire eos                     // asserted when 9999 ... 9 is reached

   ) ;


   wire [Ndigit:0] w ;   // Ndigit + 1 wires to inteconnect BCD counters each other

   assign w[0] = en ;

   generate

      genvar k ;

      for(k = 0; k < Ndigit; k = k+1) begin : digit  

         BCD_counter_en   digit (

            .clk      (             clk ),
            .rst      (             rst ),
            .en       (            w[k] ),
            .BCD      (  BCD[4*k+3:4*k] ),
            .carryout (          w[k+1] )

         ) ;

      end // for

   endgenerate


   // generate end-of-scale flag when 9999 ... 9 is reached
   assign eos = ( BCD == {Ndigit{4'b1001}} ) ? 1'b1 : 1'b0 ;      // use Verilog replication operator to replicate 4'1001 N times

   // generate overflow flag
   assign overflow = w[Ndigit] ;    // simply the carry-out of the most-significant BCD counter

endmodule

