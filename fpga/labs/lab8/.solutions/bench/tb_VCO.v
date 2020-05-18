//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_VCO.v [TESTBENCH]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 18, 2020
// [Modified]       -
// [Description]    Verilog testbench for VCO mixed-signal real model.
// [Notes]          -
// [Version]        1.0
// [Revisions]      18.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module tb_VCO ;

   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg clk ;
   real Vctrl ;   // analog control voltage

   VCO   DUT (.Vctrl(Vctrl), .clk(clk)) ;


   /////////////////////////
   //   analog stimulus   //
   /////////////////////////

   initial begin
	#0    Vctrl = 1.25 ;
        #3000 Vctrl = 2.00 ;
        #3000 Vctrl = 0.50 ;
        #3000 Vctrl = 0.78 ;
        #3000 Vctrl = 1.25 ;

        #3000 $finish ;
     end

endmodule

