//
// Verilog code for a simple D-latch
//


`timescale 1ns / 100ps

module DFF (

   input  wire D, EN,
   output reg Q

   ) ;


   always @(D,EN) begin

      if (EN) begin
         Q <= D ;
      end
      //else begin        // **IMPORTANT: if you don't specify the 'else' condition the tool automatically INFERS MEMORY for you !
      //   Q <= Q ;
      //end

   end  // always

endmodule

