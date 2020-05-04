//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       MUX.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        Apr 30, 2020
// [Modified]       -
// [Description]    Verilog description of a simple 2:1 multiplexer using different cosing styles.
//
// [Notes]          Comment/uncomment the code according to the actual implementation you want to
//                  simulate in your testbench.
//
// [Version]        1.0
// [Revisions]      30.04.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module MUX (

   input  wire A, B, S,
   //output wire Z             // Z must be declared as 'wire' if assigned through 'assign' or gate primitives, otherwise
   output reg Z                // the net type must be 'reg' if Z is used within a procedural block such as 'always' 

   ) ;


   ////////////////////////////////
   //   behavioral description   //
   ////////////////////////////////

   // using an if/else statement

   always @(A,B,S) begin          // **IMPORTANT: this is a COMBINATIONAL block, all signals contribute to the SENSITIVITY LIST

      if( S == 1'b0 ) begin       // **NOTE: the C-style equality operator checks if the condition is true or false
         Z = A ;
      end
      else begin
         Z = B ;
      end
   end  // always


   // using a case statement

   /*
   always @(*) begin              // as recommended by the Verilog standard, use always @(*) to describe COMBINATIONAL blocks

      case({S,A,B})

         3'b000 : Z = 1'b0 ;  // A
         3'b001 : Z = 1'b0 ;  // A
         3'b010 : Z = 1'b1 ;  // A
         3'b011 : Z = 1'b1 ;  // A
         3'b100 : Z = 1'b0 ;  // B
         3'b101 : Z = 1'b1 ;  // B
         3'b110 : Z = 1'b0 ;  // B
         3'b111 : Z = 1'b1 ;  // B

      endcase
   end  // always
   */

   ////////////////////////////////
   //   conditional assignment   //
   ////////////////////////////////

   //assign Z = (S == 1'b0) ? A : B ;  




   //////////////////////////
   //   boolean function   //
   //////////////////////////

   //assign Z = (A & ~S) | (B & S) ;



   ////////////////////////////////////
   //   schematic using primitives   //
   ////////////////////////////////////

/*
   wire w1, w2, Sbar ;

   not u1 (Sbar, S) ;

   and u2 (w1, A, Sbar) ;
   and u2 (w2, B, S) ;

   or  u3 (Z, w1, w2) ;

*/

endmodule

