//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_Gates.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        Apr 28, 2020
// [Modified]       -
// [Description]    Simple testbench to simulate basic logic gates with different implementations.
//
// [Notes]          Uncomment the DUT that you want to simulate.
//
// [Version]        1.0
// [Revisions]      28.04.2020 - Created
//-----------------------------------------------------------------------------------------------------

`timescale 1ns / 100ps

module tb_Gates ;

   // 40 MHz clock generator
   reg clk = 1'b0 ;

   always #12.5 clk = ~ clk ;

   // 2-bits counter
   reg [1:0] count = 2'b00 ;

   always @(posedge clk)
      count <= count + 1'b1 ;    // **WARN: be aware of the casting ! This is count[2:0] <= count[2:0] + 1'b1 !

   // device under test (DUT)
   wire [5:0] Z;

   //Gates           DUT (.A(count[0]), .B(count[1]), .Z(Z)) ;      // **UNCOMMENT** here the DUT that you want to simulate
   //GatesCase       DUT (.A(count[0]), .B(count[1]), .Z(Z)) ;
   //GatesPrimitives DUT (.A(count[0]), .B(count[1]), .Z(Z)) ;

   // simulation time
   initial
      #(4*25) $finish ;   // 4x clock cycles

endmodule

