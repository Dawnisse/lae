//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       Ndigit_7seg_display.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        Mar 19, 2020
// [Modified]       -
// [Description]    3-digit BCD counter with 7-segment display anodes multiplexing.
// [Notes]          -
// [Version]        1.0
// [Revisions]      19.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


//
// Dependencies:
//
// rtl/BCD_counter_Ndigit.v
// rtl/SevenSegmentDisplayDecoder.v
//


`define NUMBER_OF_DIGITS 3

`timescale 1ns / 100ps

module Ndigit_7seg_display (

   input wire clk, rst, en,

   input wire BTN,

   output wire segA,
   output wire segB,
   output wire segC,
   output wire segD,
   output wire segE,
   output wire segF,
   output wire segG,
   output reg [2:0] seg_anode 
   
   ) ;


   //////////////////////////////
   //   free-running counter   //
   //////////////////////////////

   reg [24:0] count = 25'd0 ;
   
   always @(posedge clk) begin
      count <= count + 1'b1 ;
   end
   
   // count slice fed to BCD counter
   wire clk_div = count[22] ;             // **WARN: this is a **BAD** hardware design practice ! Use a "ticker" in real life instead !


   // control slice
   wire [1:0] count_slice ;
   assign count_slice = count[19:18] ;    // this choice determines the refresh frequency
   
   
   
   /////////////////////////////
   //   3-digit BCD counter   //
   /////////////////////////////

   wire [11:0] BCD ;

   BCD_counter_Ndigit  #(.Ndigit(`NUMBER_OF_DIGITS)) counter (

      //.clk  (  clk_div ),         // choose here to count pulses from FPGA push-button or from the divided clock
      .clk  (      BTN ),
      .en   (       en ),
      .rst  (      rst ),
      .BCD  (      BCD )

   ) ;



   //////////////////////////////
   //   multiplex BCD slices   //
   /////////////////////////////

   reg [3:0] BCD_mux ;
   
   always @(*) begin
   
      case( count_slice[1:0] )
   
         2'b00   : BCD_mux[3:0] <= BCD[3 :0] ;
         2'b01   : BCD_mux[3:0] <= BCD[7 :4] ;
         2'b10   : BCD_mux[3:0] <= BCD[11:8] ;

         default : BCD_mux[3:0] <= BCD[3 :0] ;

      endcase
   end
   
   
   ///////////////////////////////////////
   //   anodes binary/one-hot decoder   //
   ///////////////////////////////////////
   
   //     slice   |    seg_anode
   //      00     |        001
   //      01     |        010
   //      10     |        100
   //
   //               _                  _
   // _____________/ \________________/ \____  seg_anode[2]
   //             _                  _
   // ___________/ \________________/ \______  seg_anode[1]
   //           _                  _
   // _________/ \________________/ \________  seg_anode[0]


   // compact procedural code using a Verilog for-loop

   integer i ;

   always @(*) begin   // pure combinational block

      for (i = 0 ; i < `NUMBER_OF_DIGITS ; i = i+1) begin

         seg_anode[i] = ( count_slice[1:0] == i ) ;

      end  // for
   end  // always

   // alternatively, use concurrent conditional assignments on wires

   //assign seg_anode[0] = ( count_slice == 2'b00 ) ? 1'b1 : 1'b0 ;
   //assign seg_anode[1] = ( count_slice == 2'b01 ) ? 1'b1 : 1'b0 ;
   //assign seg_anode[2] = ( count_slice == 2'b10 ) ? 1'b1 : 1'b0 ;
   // etc.



   //////////////////////////////////////////
   //   BCD to 7-segment display decoder   //
   //////////////////////////////////////////

   wire UNCONNECTED ;

   SevenSegmentDisplayDecoder  SevenSegmentDisplayDecoder (

      .BCD   ( BCD_mux[3:0] ),
      .segA  (         segA ),
      .segB  (         segB ),
      .segC  (         segC ),
      .segD  (         segD ),
      .segE  (         segE ),
      .segF  (         segF ),
      .segG  (         segG ),
      .segDP (  UNCONNECTED )

   ) ;

endmodule

