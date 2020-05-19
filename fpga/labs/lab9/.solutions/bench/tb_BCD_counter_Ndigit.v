//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_BCD_counter_Ndigit.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 19, 2020
// [Modified]       -
// [Description]    Testbench module for parameterizable N-digit BCD counter.
// [Notes]          -
// [Version]        1.0
// [Revisions]      19.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies:
//
// bench/ClockGen.v
// rtl/BCD_counter_Ndigit.v
// rtl/TickCounter.v
//


`define NUMBER_OF_DIGITS 4   // this is called a Verilog MACRO, similar to C/C++ macros e.g. #define PI 3.141592

`timescale 1ns / 100ps


module tb_BCD_counter_Ndigit ;


   /////////////////////////
   //   clock generator   //
   /////////////////////////

   wire clk100 ;

   ClockGen ClockGen_inst (.clk(clk100)) ;



   ////////////////
   //   ticker   //
   ////////////////

   // assert a single clock-pulse every 1 us i.e. 100 x 10 ns clock period at 100 MHz

   wire enable ;

   TickCounter  #(.MAX(100)) TickCounter_inst ( .clk(clk100), .tick(enable)) ;



   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg rst ;

   wire [3:0] BCD_0, BCD_1, BCD_2, BCD_3 ;  // each 4-bit slice of the BCD counter is a "digit" in decimal

   BCD_counter_Ndigit #(.Ndigit(`NUMBER_OF_DIGITS)) DUT ( .clk(clk100), .rst(rst), .en(enable), .BCD( { BCD_3 , BCD_2 , BCD_1 , BCD_0 } )) ;



   //////////////////
   //   stimulus   //
   //////////////////

   initial begin

      #72 rst = 1'b1 ;

      // release the reset
      #515 rst = 1'b0 ;

      #(1000*2157) force enable = 1'b0 ; $display("Effective number of counts from BCD counter : %d%d%d%d", BCD_3 , BCD_2 , BCD_1 , BCD_0 ) ;

      #500 $finish  ;
   end


// **WARN: original stimulus (count clock pulses every 10 ns)

/*

   //realtime t1, t2 ;              // **WARN: 'realtime' is 64-bit DOUBLE-precision floating point to be used with $realtime system task
   time t1, t2 ;                    // **WARN: 'time' is 64-bit UNSIGNED integer to be used with $time system task (in ps since timescale is ps)

   initial begin

      #72 rst = 1'b1 ; enable = 1'b0 ;

      // release the reset
      #515 rst = 1'b0 ;

      #500   enable = 1'b1 ; t1 = $time ;
      #10843 enable = 1'b0 ; t2 = $time ;

      $display("\n**INFO: Expected number of clock cycles counted by BCD counter : %d", (t2-t1)/10.0 ) ;
      $display("        Effective number of counts from BCD counter : %d%d%d%d", BCD_3 , BCD_2 , BCD_1 , BCD_0 ) ;

      #3000 $finish  ;

   end

*/

endmodule

