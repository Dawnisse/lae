//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_FIFO.v [TESTBENCH]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 21, 2020
// [Modified]       -
// [Description]    Example testbench to simulate an 8-bit wide First-In Fisrt-Out (FIFO) memory.
//
// [Notes]          The $stop Verilog task is executed whenever a FIFO-full condition is detected.
//                  The simulation can continue by issuing "run all" in the XSim Tcl console.
//
// [Version]        1.0
// [Revisions]      21.05.2020 - Created
//-----------------------------------------------------------------------------------------------------

//
// Dependencies :
//
// rtl/FIFO.v
//


`define FIFO_WIDTH  8   // useless in this testbench, just to remind us that if needed we can also use macros in Verilog ...
`define FIFO_DEPTH 32


`timescale 1ns / 100ps

module tb_FIFO ;


   /////////////////////////////////
   //   100 MHz clock generator   //
   /////////////////////////////////

   wire clk100 ;

   ClockGen  ClockGen_inst ( .clk(clk100) ) ;



   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg rst ;

   reg wr_enable = 1'b0 ;
   reg rd_enable = 1'b0 ;

   reg  [7:0] wr_data = 8'h00 ;
   wire [7:0] rd_data ;

   FIFO   DUT (

      // clock and reset
      .Clock     (       clk100 ),
      .Reset     (          rst ),

      // write section
      .WrEnable  (    wr_enable ),
      .WrData    ( wr_data[7:0] ),

      // read section
      .RdEnable  (    rd_enable ),
      .RdData    ( rd_data[7:0] ),

      // diagnostics
      .Full      (         full ),
      .Empty     (        empty )

      ) ;



   //////////////////
   //   stimulus   //
   //////////////////


   //
   // reset process
   //
   initial begin
      #72  rst = 1'b1 ;    // assert reset
      #100 rst = 1'b0 ;    // release reset
   end


   //
   // write process
   //
   integer wr ;

   initial begin

      #300   // wait for reset to be released

      for (wr = 0; wr < 100; wr = wr+1) begin

         #100 wr_data[7:0] = $random ;

         @(posedge clk100) wr_enable = 1'b1 ;    // "dirty" way to generate a single clock-pulse control signal
         @(posedge clk100) wr_enable = 1'b0 ;
      end

   end

   //
   // read process
   //
   integer rd ;

   initial begin

      #300   // wait for reset to be released

      #400   // start reading only after 800ns

      for( rd = 0; rd < 32; rd = rd+1) begin

         #100

         @(posedge clk100) rd_enable = 1'b1 ;    // "dirty" way to generate a single clock-pulse control signal
         @(posedge clk100) rd_enable = 1'b0 ;
      end


      #4000   // stop reading, meanwhile the FIFO goes FULL !

      for (rd = 0; rd < 70; rd = rd+1) begin

         #100

         @(posedge clk100) rd_enable = 1'b1 ;
         @(posedge clk100) rd_enable = 1'b0 ;
      end

      #1000 $finish ;

   end


   //
   // monitor FIFO status
   //
   always @(posedge full) begin

      $display("\n\n**BAD** ! FIFO-full condition detected at %f us !\n\n", ($realtime)*1e-3 ) ;

      #100 $stop ;  // suspend the simulation and enter into interactive debug mode (but the simulation can continue by issuing "run all" in the XSim Tcl console)

   end

endmodule
