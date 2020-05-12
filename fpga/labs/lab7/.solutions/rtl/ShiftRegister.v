//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       ShiftRegister.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 12, 2020
// [Modified]       -
// [Description]    Verilog code for a simple 8-bit shift-left register with positive-edge clock,
//                  asynchronous parallel load, serial-in, and serial-out.
// [Notes]          -
// [Version]        1.0
// [Revisions]      12.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module ShiftRegister #(parameter [7:0] INIT = 8'h00) ( 

   input  wire clk,
   input  wire SI,                  // serial-in
   input  wire [7:0] PDATA,         // 8-bit parallel-data
   input  wire LOAD,                // load 1, shift 0
   output wire SO                   // serial-out

   ) ;



   // startup value
   reg [7:0] q = INIT ;            // this works also on FPGA thanks to the Global Set/Reset (GSR) when firmware is downloaded !

   always @(posedge clk) begin

      // load mode
      if(LOAD) begin
         q <= PDATA ;
      end

      // shift-mode otherwise
      else begin
         q[7:0] <= { q[6:0] , SI } ;     // shift-left using concatenation

         // **NOTE: this is equivalent to :
         // q[0] <= SI ;
         // q[1] <= q[0] ;
         // q[2] <= q[1] ;
         // ...
         // ...
         // q[7] <= q[6] ;

      end   // if
   end   // always


   // assign the MSB to serial-out
   assign SO = q[7] ;

endmodule

