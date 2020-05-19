//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       BCD_counter_en.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 19, 2020
// [Modified]       -
// [Description]    Binary-coded decimal (BCD) counter with count-enable and overflow.
// [Notes]          -
// [Version]        1.0
// [Revisions]      19.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module BCD_counter_en (

   input  wire clk,
   input  wire rst,
   input  wire  en,
   output reg [3:0] BCD,
   output wire carryout 

   ) ;
   

   always @(posedge clk) begin                              // synchronous reset
   //always @(posedge clk or posedge rst) begin 	    // asynchronous reset

      if( rst == 1'b1 )
         BCD <= 4'b0000 ;

      else begin

         if( en == 1'b1 ) begin      // let the counter to increment only if enabled !

            if( BCD == 4'b1001 )     // force the count roll-over at 9
               BCD <= 4'b0000 ;
            else
               BCD <= BCD + 1 ;
         end

      end
   end // always


   assign carryout = ( (BCD == 4'b1001) && (en == 1'b1) ) ? 1'b1 : 1'b0 ;

endmodule
