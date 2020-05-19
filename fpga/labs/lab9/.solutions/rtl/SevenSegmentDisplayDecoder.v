//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       SevenSegmentDisplayDecoder.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 19, 2020
// [Modified]       -
// [Description]    BCD to 7-segments display decoder. Assume to drive a COMMON ANODE device.
// [Version]        1.0
// [Revisions]      19.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies :
//
// n/a
//

//
// **NOTE
//
// A seven-segment display is simply a colletion of seven individual coloured LEDs (called "segments")
// in a common-anode (CA) or common-cathode (CC) configuration.
// By turning on/off the LEDs withcproper pattern we can display all "digits" of the decimal system 0,1 ... 9
// plus letters of the HEX systems.
// This can be achieved by driving the LEDs with a BCD to 7-segment display DECODER, which is a pure
// combinational block that maps a 4-bit string with BCD representation into seven LED controls.
// 
//       a
//      ____
//     |    |
//   f |    | b
//     | g  |
//      ----
//     |    |
//   e |    | c
//     |    |
//      ----  o  DP
//       d
//


`timescale 1ns / 100ps

module SevenSegmentDisplayDecoder (

   input  wire [3:0] BCD,     // 4-bit BCD input code

   output reg segA,           // "segments" of the display are referred to as "a", "b", "c", "d", "e", "f" and "g"
   output reg segB,
   output reg segC,
   output reg segD,
   output reg segE,
   output reg segF,
   output reg segG,
   output reg segDP           // optionally, drive also the decimal point

   ) ;


   // pure combinational block
   always @(*) begin
   
      case( BCD[3:0] )
                                                                        //  abcdefg-
         4'b0000  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b00000011 ;  //  0
         4'b0001  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b10011111 ;  //  1
         4'b0010  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b00100101 ;  //  2
         4'b0011  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b00001101 ;  //  3
         4'b0100  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b10011001 ;  //  4
         4'b0101  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b01001001 ;  //  5
         4'b0110  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b01000001 ;  //  6
         4'b0111  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b00011111 ;  //  7
         4'b1000  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b00000001 ;  //  8
         4'b1001  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b00001001 ;  //  9
         
         default  :  {segA, segB, segC, segD, segE, segF, segG, segDP} = 8'b11111101 ;  // minus sign otherwise

      endcase
   end

endmodule

