//-----------------------------------------------------------------------------------------------------
//                               University of Torino - Department of Physics
//                                   via Giuria 1 10125, Torino, Italy
//-----------------------------------------------------------------------------------------------------
// [Filename]       ROM.v [RTL]
// [Project]        Advanced Electronics Laboratory course
// [Author]         Luca Pacher - pacher@to.infn.it
// [Language]       Verilog 2001 [IEEE Std. 1364-2001]
// [Created]        May 21, 2020
// [Modified]       -
// [Description]    Parameterized Read-Only Memory (ROM) in Verilog. Use the ROM_STYLE synthesis
//                  pragma to instruct the tool how to infer the ROM memory in FPGA hardware :
//
//                     (* rom_style = "block" *)         => infer BRAM components
//                     (* rom_style = "distributed" *)   => infer LUTs components
//
//                  This can be set either in RTL code or in XDC as set_property. By default the
//                  tool selects which ROM style to infer based on heuristics that give the best
//                  results for the most designs. ROM initial values can be specified in the code
//                  or in an external file imported using $readmemb() or $readmemh() tasks.
//
// [Notes]          Ref. also to Vivado Synthesis user guide (UG901)
//
//                  https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug901-vivado-synthesis.pdf
//
// [Version]        1.0
// [Revisions]      21.05.2020 - Created
//-----------------------------------------------------------------------------------------------------


//
// Dependencies :
//
// rtl/ROM.hex
//


`timescale 1ns / 100ps

module ROM #(parameter integer WIDTH = 8, parameter integer DEPTH = 64) (

   input  wire clk,
   input  wire en,
   input  wire [$clog2(DEPTH)-1:0] address,
   output reg [WIDTH-1:0] data

   ) ;

   (* rom_style = "block" *)                   // this is a first example of a SYNTHESIS PRAGMA, instruct the tool how to infer the ROM memory with LUTs or BRAMs
   reg [WIDTH-1:0] mem [0:DEPTH-1] ;


   ////////////////////
   //   read logic   //
   ////////////////////

   always @(posedge clk)
      if(en)
         data <= mem[address] ;


   ////////////////////////////
   //   ROM initialization   //
   ////////////////////////////

   initial begin

      // initialize the ROM using an external file...
      $readmemh("../../rtl/ROM.hex", mem) ;

      // or simply specify in the initial block ROM values for each address

/*
      mem[ 0] = 8'h41 ;
      mem[ 1] = 8'h70 ;
      mem[ 2] = 8'h6f ;
      mem[ 3] = 8'h6c ;
      mem[ 4] = 8'h6f ;
      mem[ 5] = 8'h67 ;
      mem[ 6] = 8'h69 ;
      mem[ 7] = 8'h7a ;
      mem[ 8] = 8'h65 ;
      mem[ 9] = 8'h20 ;
      mem[10] = 8'h66 ;
      mem[11] = 8'h6f ;
      mem[12] = 8'h72 ;
      mem[13] = 8'h20 ;
      mem[14] = 8'h74 ;
      mem[15] = 8'h68 ;
      mem[16] = 8'h65 ;
      mem[17] = 8'h20 ;
      mem[18] = 8'h62 ;
      mem[19] = 8'h61 ;
      mem[20] = 8'h64 ;
      mem[21] = 8'h20 ;
      mem[22] = 8'h6c ;
      mem[23] = 8'h65 ;
      mem[24] = 8'h63 ;
      mem[25] = 8'h74 ;
      mem[26] = 8'h75 ;
      mem[27] = 8'h72 ;
      mem[28] = 8'h65 ;
      mem[29] = 8'h20 ;
      mem[30] = 8'h61 ;
      mem[31] = 8'h75 ;
      mem[32] = 8'h64 ;
      mem[33] = 8'h69 ;
      mem[34] = 8'h6f ;
      mem[35] = 8'h20 ;
      mem[36] = 8'h71 ;
      mem[37] = 8'h75 ;
      mem[38] = 8'h61 ;
      mem[39] = 8'h6c ;
      mem[40] = 8'h69 ;
      mem[41] = 8'h74 ;
      mem[42] = 8'h79 ;
      mem[43] = 8'h20 ;
      mem[44] = 8'h79 ;
      mem[45] = 8'h65 ;
      mem[46] = 8'h73 ;
      mem[47] = 8'h74 ;
      mem[48] = 8'h65 ;
      mem[49] = 8'h72 ;
      mem[50] = 8'h64 ;
      mem[51] = 8'h61 ;
      mem[52] = 8'h79 ;
      mem[53] = 8'h2c ;
      mem[54] = 8'h20 ;
      mem[55] = 8'h73 ;
      mem[56] = 8'h6f ;
      mem[57] = 8'h72 ;
      mem[58] = 8'h72 ;
      mem[59] = 8'h79 ;
      mem[60] = 8'h20 ;
      mem[61] = 8'h21 ;
      mem[62] = 8'h21 ;
      mem[63] = 8'h21 ;
*/

   end

endmodule

