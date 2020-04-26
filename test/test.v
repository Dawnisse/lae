//
// sample Verilog code to test tools installation
//

`timescale 1ns/1ps

module test ;

   reg clk = 1'b0 ;

   always #50 clk = ~ clk ;

   reg [4:0] count = 5'b00000 ;

   always @(posedge clk)
      count <= count + 1 ;

   initial begin
      #1000 $finish ;

   end


endmodule
