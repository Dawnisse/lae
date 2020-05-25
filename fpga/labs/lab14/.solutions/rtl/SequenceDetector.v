//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       SequenceDetector.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 25, 2020
// [Modified]       -
// [Description]    Example Moore Finite State Machine (FSM) for 110 sequence detector.
// [Notes]          -
// [Version]        1.0
// [Revisions]      25.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies :
//
// n/a
//


// choose here the desired encoding style for FSM states

`define STATES_ENCODING_BINARY
//`define STATES_ENCODING_GRAY
//`define STATES_ENCODING_ONEHOT


`timescale 1ns / 100ps

module SequenceDetector (

   input  wire clk,
   input  wire reset,            // synchronous reset, active-high
   input  wire si,               // serial-in
   output reg  detected          // single clock-pulse output asserted when 110 is detected

   ) ;


   ///////////////////////////
   //   states definition   //
   ///////////////////////////

`ifdef STATES_ENCODING_BINARY

   parameter [1:0] S0 = 2'b00 ;
   parameter [1:0] S1 = 2'b01 ;
   parameter [1:0] S2 = 2'b10 ;
   parameter [1:0] S3 = 2'b11 ;

   reg [1:0] STATE, STATE_NEXT ;

`endif


`ifdef STATES_ENCODING_GRAY

   parameter [1:0] S0 = 2'b00 ;
   parameter [1:0] S1 = 2'b01 ;
   parameter [1:0] S2 = 2'b11 ;
   parameter [1:0] S3 = 2'b10 ;

   reg [1:0] STATE, STATE_NEXT ;

`endif


`ifdef STATES_ENCODING_ONEHOT

   parameter [3:0] S0 = 2'b0001 ;
   parameter [3:0] S1 = 2'b0010 ;
   parameter [3:0] S2 = 2'b0100 ;
   parameter [3:0] S3 = 2'b1000 ;

   reg [3:0] STATE, STATE_NEXT ;

`endif



   /////////////////////////////////////////////////
   //   next-state logic (pure sequential part)   //
   /////////////////////////////////////////////////

   always @(posedge clk) begin      // infer a bank of FlipFlops

      if(reset)
         STATE <= S0 ;

      else
         STATE <= STATE_NEXT ;

   end   // always



   ////////////////////////////
   //   combinational part   //
   ////////////////////////////

   always @(*) begin

      detected = 1'b0 ;

      case ( STATE )

         default : STATE_NEXT = S0 ;   // **IMPORTANT ! Use a "catch-all" condition to cover all remaining codes, LATCHES inferred otherwise !

         S0 : begin

            detected = 1'b0 ;

            if(si == 1'b1)
               STATE_NEXT = S1 ;
            else 
               STATE_NEXT = S0 ;

         end

         //_____________________________
         //

         S1 : begin

            detected = 1'b0 ;

            if(si == 1'b1)
               STATE_NEXT = S2 ;
             else
               STATE_NEXT = S0 ;
         end

         //_____________________________
         //

         S2 : begin

            detected = 1'b0 ;

            if(si == 1'b0)
               STATE_NEXT = S3 ;
            else
               STATE_NEXT = S2 ;
         end

         //_____________________________
         //

         S3 : begin

            detected = 1'b1 ;       // sequence detected !

            if(si == 1'b1)
               STATE_NEXT = S1 ;
            else
               STATE_NEXT = S0 ;
         end

      endcase

   end   // always

endmodule

