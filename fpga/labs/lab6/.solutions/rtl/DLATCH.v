//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       DFF.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 11, 2020
// [Modified]       -
// [Description]    Verilog code for a simple D-Latch. 
// [Notes]          -
// [Version]        1.0
// [Revisions]      11.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module DLATCH (

   input  wire D, EN,
   output reg Q

   ) ;


   // behavioural description
   always @(D,EN) begin          // **NOTE: can be replaced by 'always_latch' in SystemVerilog

      if (EN) begin
         Q <= D ;
      end
      //else begin        // **IMPORTANT: in this case the 'else' clause is optional, if you don't specify the 'else' condition the tools automatically infer MEMORY for you !
      //   Q <= Q ;
      //end

   end  // always

endmodule

