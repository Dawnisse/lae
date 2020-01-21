
`timescale 1ns / 1ps

module BasicLogicGates (

   input  wire A,
   input  wire B,
   output wire [5:0] Z

   ) ;

   // 2-inputs AND gate
   assign Z[0] = A & B ;

   // 2-inputs OR gate
   assign Z[1] = A | B ;

   // 2-inputs NAND gate
   assign Z[2] = ~(A & B) ;

   // 2-inputs NOR gate
   assign Z[3] = ~(A | B) ;

   // 2-inputs XOR gate
   assign Z[4] = A ^ B ;

   // 2-inputs XNOR gate
   assign Z[5] = ~(A ^ B) ;

endmodule

