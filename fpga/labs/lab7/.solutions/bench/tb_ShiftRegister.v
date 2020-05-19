//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_ShiftRegister.v [TESTBENCH]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 12, 2020
// [Modified]       -
// [Description]    Verilog testbench for ShiftRegister module.
// [Notes]          -
// [Version]        1.0
// [Revisions]      12.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module tb_ShiftRegister ;


   /////////////////////////
   //   clock generator   //
   /////////////////////////

   wire clk ;

   ClockGen #(.PERIOD(100.0)) ClockGen_inst ( .clk(clk) ) ;


   ////////////////////////////////////////////////////////
   //   PLL to double the input clock (Xilinx IP core)   //
   ////////////////////////////////////////////////////////

   wire clk_200, pll_locked ;

   PLL PLL_inst ( .CLK100(clk), .CLK200(clk_200), .LOCKED(pll_locked) ) ;


   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg shift0_load1 ;
   reg [7:0] data ;

   wire serial_out ;

   ShiftRegister #(.INIT(8'hFF)) DUT ( .clk(clk), .LOAD(shift0_load1), .PDATA(data), .SI(1'b0), .SO(serial_out)) ;


   //////////////////
   //   stimulus   //
   //////////////////

   initial begin

      #0   shift0_load1 = 1'b1 ; data = 8'b1010_1011 ;    // this is equivalent to 8'hAB

      @(posedge pll_locked)           // wait for PLL to lock

      #420 shift0_load1 = 1'b0 ;

      #(8*100.0)

      #500  force clk  = 1'b0 ;  // what happens to the PLL if the input clock disappears ? 
      #1000 release clk ;

      #2000 $finish ;
   end

endmodule

