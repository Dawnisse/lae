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
// [Description]    Parameterizable N-digit BCD counter.
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

   input   wire clk,
   input   wire rst,
   input   wire en,
   output  wire [Ndigit*4-1:0] BCD

   ) ;


   wire [Ndigit:0] carry ;   // roll-over flags

   assign carry[0] = en ;

   generate

      genvar k ;

      for(k = 0; k < Ndigit; k = k+1) begin : digit  

         BCD_counter_en   digit (

            .clk      (             clk ),
            .rst      (             rst ),
            .en       (        carry[k] ),
            .BCD      (  BCD[4*k+3:4*k] ),
            .carryout (      carry[k+1] )

         ) ;

      end // for

   endgenerate

endmodule
