//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       tb_MUX.v
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        Apr 30, 2020
// [Modified]       -
// [Description]    Testbench for different MUX implementations.
// [Version]        1.0
// [Revisions]      30.04.2020 - Created
//-----------------------------------------------------------------------------------------------------


`timescale 1ns / 100ps

module tb_MUX ;

   // 40 MHz clock generator
   reg clk = 1'b0 ;

   always #12.5 clk = ~ clk ;

   // 2-bits counter
   reg [1:0] count = 2'b00 ;

   always @(posedge clk)
      count <= count + 1'b1 ;    // **WARN: be aware of the casting ! This is count[2:0] <= count[2:0] + 1'b1 !

   // device under test (DUT)

   reg  select ;
   wire Z;

   MUX  DUT (.A(count[0]), .B(count[1]), .S(select), .Z(Z)) ;

   // stimulus
   initial begin

      #0   select = 1'b1 ;     // initial value at t=0

      #500 select = 1'b0 ;
      #450 select = 1'b1 ;
      #500 select = 1'b0 ;
      #450 select = 1'b1 ;
      
      #500 $finish ;           // stop the simulation
   end


   // text-based simulation output
   initial begin
      $display("\t\t\t\t time select A  B  Z") ;
      $monitor("%d   %b     %b %b %b",$time, select, count[0], count[1], Z) ;
   end


   // dump waveforms into industry-standard Value Change Dump (VCD) database
   initial begin
      $dumpfile ("waveforms.vcd") ;
      $dumpvars ;
   end

endmodule

