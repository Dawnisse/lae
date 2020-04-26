//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_Inverter.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 1995 [IEEE Std. 1364-1995]
// [Created]        Apr 26, 2020
// [Modified]       -
// [Description]    Simple testbench for the Inverter module
// [Notes]          -
// [Version]        1.0
// [Revisions]      02.03.2016 - Created
//-----------------------------------------------------------------------------------------------------

`timescale 1ns / 1ps

module tb_Inverter ;

   reg X ;      // note that this is declared as 'reg' net type
   wire ZN ;

   // instantiate the module under test (MUT)
   Inverter MUT ( .X(X), .ZN(ZN) ) ;

   // stimulus
   initial begin
   
      #500 X = 1'b0 ;
      #200 X = 1'b1 ;
      #750 X = 1'b0 ;
      
      #500 $finish ;     // this is a Verilog "task" 
   end

endmodule
