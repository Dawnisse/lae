//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       VCO.sv [RNM]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       SystemVerilog 2012 [IEEE Std. 1800-2012]
// [Created]        May 18, 2020
// [Modified]       -
// [Description]    Example real-number model (RNM) using SystemVerilog real ports for a simple
//                  voltage-controlled oscillator (VCO).
//
// [Notes]          **NON SYNTHESIZABLE CODE** !
//
// [Version]        1.0
// [Revisions]      18.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module VCO (

   input  real  Vctrl,     // analog control voltage using a 'real' input port, only supported by SystemVerilog
   output logic clk        // SystemVerilog 'logic' net type, same as 'reg'

   ) ;

   // VCO parameters
   parameter real INTRINSIC_FREQ = 2.5 ;  // MHz
   parameter real VCO_GAIN = 10 ;         // V/MHz

   real clk_delay ;
   real freq ;

   initial begin
      clk = 1'b0 ;
      freq = INTRINSIC_FREQ ;         // initial frequency
      clk_delay = 1.0/(2*freq) ;      // initial semi-period
    end


   // change the clock frequency whenever the control voltage changes
   always @(Vctrl) begin
      freq = INTRINSIC_FREQ + VCO_GAIN*Vctrl ;
      clk_delay = 1.0/(2*freq)*1e3 ;
   end

   // clock generator
   always #clk_delay clk = ~clk ;

endmodule : VCO
