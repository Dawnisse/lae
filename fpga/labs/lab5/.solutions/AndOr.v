
`timescale 1ns / 100ps

module AndOr (

   input  wire A,B,C,
   output wire Z

   ) ;

   assign Z = (A & B) | C ;

endmodule
