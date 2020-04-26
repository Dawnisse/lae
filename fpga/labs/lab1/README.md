# Lab 1 Instructions

In this first lab we will implement **a simple inverter** using Verilog and simulate the code using the **Xilinx Xsim simulator**.

As a first step, **open a terminal** and go inside the `lab1/` directory :

```
% cd Desktop/lae/fpga/labs/lab1
```

With a **text editor** program create a new file named `Inverter.v`.

Linux users can use the default `gedit` text editor :

```
% gedit Inverter.v &
```

Windows users will use Notepad++ instead :

```
% npp Inverter.v
```

The source code is the following :

```Verilog
//
// A simple inverter in Verilog
//

`timescale 1ns / 1ps   // specify time-unit and time-precision, this is only for simulation purposes

module Inverter (

   input  wire X,
   output wire ZN ) ;   // this is reduntant, by default I/O ports are always considered WIRES unless otherwise specified


   // continuous assignment
   assign ZN = !X ;

endmodule
```

Once ready, try to **parse and compile** the above code using the `xvlog` Verilog compiler :

```
% xvlog Inverter.v
```

In case of syntax errors, fix the errors and re-compile the source file after saving changes.

In order to **simulate** the block we also need a **testbench module** to create a test pattern for our inverter.

Create a second Verilog file named `tb_Inverter.v` as follows :

```
% gedit tb_Inverter.v &
```

or

```
% npp tb_Inverter.v
```

The testbench code is the following :

```verilog
//
// Simple testbench for the Inverter module
//

`timescale 1ns / 1ps

module tb_Inverter ;

   reg X ;      // note that this is declared as 'reg' net type
   wire ZN ;

   // instantiate the module under test (MUT)
   Inverter MUT ( .X(X), .ZN(ZN) ) ;

   // stimulus
   initial begin
   
      #500 X = 1'b0 ;
      #200 X = 1'b1 ;
      #750 X = 1'b0 ;
      
      #500 $finish ;     // this is a Verilog "task" 
   end

endmodule
```
Parse and compile also the testbench code :

```
% xvlog tb_Inverter.v
```

In order to **simulate the testbench** we have at first to **merge toghether** the compiled code
of our **module under test (MUT)** with the compiled code of the testbench.
This process is called **elaboration** and in Xilinx Vivado is performed by the `xelab` executable.

Elaboration is always done specifying the **top-level module** of the simulation project, which is 
the name of the **testbench module** :

```
% xelab -debug all tb_Inverter
```

The `-debug all` options is **required** to make all signals **accessible** from the simulator
graphical interface in form of **digital waveforms**.

After this process a **simulation executable** is created and can be runned using the `xsim` simulator :

```
% xsim -gui tb_Inverter
```

To add waveforms in the XSim **Wave Window** type in the **Tcl console** :

```
add_wave /tb_Inverter/*
```

Finally, run the simulation with :

```
run all
```


Explore the graphical interface of the simulator. Exit.

The simulation flow automatically creates a lot of garbage files :

```
% ls -la
```

You can cleanup the working area using either

```
% source cleanup.sh   (for Linux users)
```

or

```
% call cleanup.bat    (for Windows users)
```


## Exercise

Edit the continuous assignment in order to **add 3 ns propagation delay** between input and output :

```verilog
assign #3 ZN = !X ;
```

Re-compile and re-simulate the code.


## Extra: comparison with VHDL code

Compare the Verilog syntax with its VHDL equivalent :

```vhdl


--
-- A simple inverter in VHDL
-- 


-- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)
library ieee ;
use ieee.std_logic_1164.all ;


entity Inverter is

   port (
      X  : in  std_logic ;
      ZN : out std_logic
   ) ;

end entity Inverter ;


architecture rtl of Inverter is

begin

   ZN <= not X ; 

end architecture rtl ;
```

Interested students can also try to simulate a **mixed-languge** design by compiling VHDL using the `xvhdl` compiler instead :

```
% xvhdl Inverter.vhd
% xvlog tb_Inverter.v
% xelab -debug all tb_Inverter
% xsim -gui tb_Inverter
``` 

