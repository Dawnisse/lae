//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_Inverter.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        Apr 26, 2020
// [Modified]       -
// [Description]    Simple testbench for the Inverter module.
//
// [Notes]          If you set a smaller time-precision e.g. 10ps the simulation time increases.
//
// [Version]        1.0
// [Revisions]      26.04.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps   // specify time-unit and time-precision, this is only for simulation purposes

module tb_Inverter ;

   reg in ;      // note that this is declared as 'reg' net type
   wire out ;

   // instantiate the device under test (DUT)
   Inverter DUT ( .X(in), .ZN(out) ) ;

   // stimulus
   initial begin
   
      #500 in = 1'b0 ;
      #200 in = 1'b1 ;
      #750 in = 1'b0 ;

      #500 $finish ;     // stop the simulation (this is a Verilog "task")
   end

endmodule
