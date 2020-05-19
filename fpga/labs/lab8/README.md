# Lab 8 Instructions

In this lab we simulate a **mixed-signal block** such as a **voltage-controlled oscillator (VCO)** using a **pure-digital simulation** 
with **real numbers** and **SystemVerilog real ports**.


As a first step, open a terminal and go inside the `lab8/` directory :

```
% cd Desktop/lae/fpga/labs/lab8
```

Copy from the `.solutions/` directory the main `Makefile` already prepared for you :

```
% cp .solutions/Makefile .
```

Explore available targets :

```
% make help
```

Create a new fresh working area :

```
% make area
```

Create a first new **SystemVerilog** simulation source `bench/VCO.sv` with the following content :

```SystemVerilog
`timescale 1ns / 100ps

module VCO (

   input  real  Vctrl,     // analog control voltage using a 'real' input port, only supported by SystemVerilog
   output logic clk        // SystemVerilog 'logic' net type, same as 'reg'

   ) ;

   // VCO parameters
   parameter real INTRINSIC_FREQ = 2.5 ;  // MHz
   parameter real VCO_GAIN = 10 ;         // MHz/V

   real clk_delay ;
   real freq ;

   initial begin
      clk = 1'b0 ;
      freq = INTRINSIC_FREQ ;             // initial frequency
      clk_delay = 1.0/(2*freq)*1e3 ;      // initial semi-period
    end


   // change the clock frequency whenever the control voltage changes
   always @(Vctrl) begin
      freq = INTRINSIC_FREQ + VCO_GAIN*Vctrl ;
      clk_delay = 1.0/(2*freq)*1e3 ;

      $display("VCO clock frequency for Vctrl = %.2f V is %2.2f MHz", Vctrl, freq) ;
   end

   // clock generator
   always #clk_delay clk = ~clk ;

endmodule : VCO
```

This is of course **NON-SYNTHESIZABLE CODE**, but **real-number models (RNM)** are very useful to model **mixed signal blocks**
connected to FPGA devices e.g. A/D and D/A converters, temperature sensors etc.


Create a second main Verilog testbench `bench/tb_VCO.v` to test the functionality of the VCO :

```verilog
`timescale 1ns / 100ps

module tb_VCO ;

   ///////////////////////////
   //   device under test   //
   ///////////////////////////

   reg clk ;
   real Vctrl ;   // analog control voltage

   VCO   DUT (.Vctrl(Vctrl), .clk(clk)) ;


   /////////////////////////
   //   analog stimulus   //
   /////////////////////////

   initial begin
        #0    Vctrl = 1.25 ;
        #3000 Vctrl = 2.00 ;
        #3000 Vctrl = 0.50 ;
        #3000 Vctrl = 0.78 ;
        #3000 Vctrl = 1.25 ;

        #3000 $finish ;
   end

endmodule
```

Copy from the `.solutions/` directory the following **Tcl simulation scripts** :


```
% cp .solutions/scripts/sim/compile.tcl    ./scripts/sim
% cp .solutions/scripts/sim/elaborate.tcl  ./scripts/sim
% cp .solutions/scripts/sim/simulate.tcl   ./scripts/sim
% cp .solutions/scripts/sim/run.tcl        ./scripts/sim
```

Despite not used, copy also the `glbl.v` Xilinx module required for the elaboration :

```
% cp .solutions/bench/glbl.v ./bench
```

Compile, elaborate and simulate this small design with :

```
% make compile
% make elaborate
% make simulate
```

or simply type

```
% make sim
```



