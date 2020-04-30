# Lab 2 Instructions

In this second lab we will introduce basic **Verilog bit-wise operators** to implement fundamental **logic gates**
such as AND, NAND, OR, NOR, XOR and XNOR.
We will also learn how to write a [**GNU Makefile**](https://www.gnu.org/software/make/manual/make.html)
to **automate the simulation flow**.

As a first step, **open a terminal** and go inside the `lab2/` directory :

```
% cd Desktop/lae/fpga/labs/lab2
```

With a **text editor** create a new file named `Gates.v`, for example :

```
% gedit Gates.v &   (for Linux users)
% npp Gates.v       (for Windows users)
```


Try to **complete** the following **code-skeleton** to implement basic
logic operations using **Verilog continuous assignments** :


```verilog
//
// Verilog basic bit-wise operators 
//

`timescale 1ns / 100ps

module Gates (

   input  wire A,
   input  wire B,
   output wire [5:0] Z     // note that Z is declared as 6-bits width output BUS

   ) ;


   // Available Verilog bit-wise logic operators are :
   // 
   // NOT  ~
   // AND  &
   // OR   |
   // XOR  ^

   // AND
   assign Z[0] = A & B ;

   // NAND
   assign Z[1] = ... ;


   // OR
   ...


   // NOR
   ...


   // XOR
   ...


   // XNOR
   ...

endmodule
```

Once ready, try to **parse and compile** the code with the `xvlog` Verilog compiler :

```
% xvlog Gates.v
```

In case of **syntax errors**, fix the errors issued in the terminal and re-compile the source file
after saving your changes.

In order to **simulate** the block we also need a **testbench module** to create a test pattern for our gates.

In this case a simple **2-bits counter** can be used to easily generate
**all possible input combinations** `2'b00`, `2'b01`, `2'b10` and `2'b11` for `A` and `B` input ports.
Thus we will also learn how to generate a **clock waveform** in Verilog.

Create a second Verilog file named `tb_Gates.v` as follows :

```
% gedit tb_Gates.v &   (for Linux users)
% npp tb_Gates.v       (for Windos users)
```

The **testbench** code is the following :

```verilog
//
// Simple testbench for the Gates module
//

`timescale 1ns / 100ps

module tb_Gates ;

   // 40 MHz clock generator
   reg clk = 1'b0 ;                 // note that we can also initialize a 'reg' to some initial value when declared

   always #12.5 clk = ~ clk ;

   // 2-bits counter
   reg [1:0] count = 2'b00 ;

   always @(posedge clk)
      count <= count + 1'b1 ;       // **WARN: be aware of the SIZE CASTING ! This is count[2:0] <= count[2:0] + 1'b1 !

   // device under test (DUT)
   wire [5:0] Z ;

   Gates DUT (.A(count[0]), .B(count[1]), .Z(Z)) ;

   // stimulus
   initial
      #(4*25) $finish ;   // here we only need to choose the simulation time, e.g. 4x clock cycles

endmodule
```

Parse and compile also the testbench code :

```
% xvlog tb_Gates.v
```

Finally, **elaborate** the top-level module and **launch the simulation** :

```
% xelab -debug all tb_Gates
% xsim -gui tb_Gates
```

<hr>

**REMINDER**

The value to be passed as main argument to `xelab` and `xsim` executables is the **NAME** of the top-level module,
**NOT the corresponding Verilog source file** ! The following command-line syntax are therefore **WRONG** :

```
% xelab -debug all tb_Gates.v
% xsim -gui tb_Gates.v
```
Do not call `xelab` or `xsim` targeting a `.v` file and **always pay attention to TAB completion on files !**

<hr>

To add all testbench waveforms in the XSim **Wave Window** type in the **Tcl console** :

```
add_wave /*
```

Finally, run the simulation with :

```
run all
```

Debug your simulation results.

All previous commands can also be collected into a **Tcl script** e.g. `run.tcl` and loaded from the Tcl console :

```
restart
source run.tcl
```

In order to save time we can profit from the fact that a **Tcl init script** can be specified as additional
argument to the `xsim` executable when invoked :

```
% xsim -gui tb_Gates -tclbatch run.tcl
```

With this syntax **all top-level waveforms** will be automatically added to the XSim Wave window and the simulation
will automatically run until a `$finish` directive is encountered.

Close the simulator graphical interface.


## Automate the simulation flow using a GNU Makefile

Up to now we learned how to **compile**, **elaborate** and **run a simulation** in Xilinx XSim by invoking
`xvlog`, `xelab` and `xsim` standalone executables at the command-line each time.

A more efficient solution is to **automate the simulation flow** by collecting these commands
inside a [**GNU Makefile**](https://www.gnu.org/software/make/manual/make.html) parsed by the `make` utility.

As a first step, create a new file named `Makefile` (without extension) :

```
% gedit Makefile &   (for Linux users)
% npp Makefile       (for Windows users)
```

Write the following code :

```make
#
# A first simple Makefile example to automate the simulation flow
#

## list of Verilog sources to be compiled
SOURCES := Gates.v tb_Gates.v

## top-level module (testbench)
TOP := tb_Gates

## some useful Linux aliases
RM := rm -f -v
RMDIR := rm -rf -v


## compile Verilog sources
compile :
	@xvlog $(SOURCES)

## elaborate the design and invoke the simulator
sim :
	@xelab -debug all $(TOP)
	@xsim -gui -tclbatch run.tcl $(TOP)

## clean the working area
clean :
	@$(RM) *.log *.jou *.pb *.wdb *.wcfg
	@$(RMDIR) xsim.dir .Xil

```

<hr>

**IMPORTANT**

According to `Makefile` syntax, instructions inside each target **MUST BE IDENTED USING A TAB** !

```
target :
<TAB>  @write here some cool stuff to be executed
```

**DO NOT USE SPACES TO IDENT TARGET DIRECTIVES !**

<hr>

Once ready, save the file and try to run the simulation flow with `make` as follows :

```
% make compile
% make sim
```


## Exercise

Instead of using logic operators we can also implement the functionality of each basic gate in terms of a **truth table**.<br/>
A Verilog `case` statement can be used for this purpose.

Create a new file e.g. `GatesCase.v` and try to **complete** the following **code skeleton** :

```Verilog
//
// Implement basic logic gates in terms of truth tables using 'case' statements
//

`timescale 1ns / 100ps

module GatesCase (

   input  wire A
   input  wire B,
   output reg [5:0] Z     // **QUESTION: why Z is now declared as 'reg' instead of 'wire' ?

   ) ;

   // AND
   always @(*) begin

      case( {A,B} )        //  concatenation operator { , }, that's why Verilog uses begin/end instead of standard C/C++ brackets {}

         2'b00 :  Z[0] = 1'b0 ;
         2'b01 :  Z[0] = 1'b0 ;
         2'b10 :  Z[0] = 1'b0 ;
         2'b11 :  Z[0] = 1'b1 ;

      endcase
   end  // always


   // NAND
   ...

   // OR
   ...

   // NOR
   ...

   // XOR
   ....

   // XNOR
   ...

endmodule
```

We can simulate this new implementation using the same previous testbench code, just **replace the name of the module you want to test**
in the `tb_Gates.v` file :

```verilog
// device under test (DUT)

//Gates DUT (.A(count[0]), .B(count[1]), .Z(Z)) ;       **COMMENT** the previous DUT !
GatesCase DUT (.A(count[0]), .B(count[1]), .Z(Z)) ;

```

Update your `Makefile` to parse and compile `GatesCase.v` instead of `Gates.v` :


```make
#SOURCES := Gates.v tb_Gates,v
SOURCES := GatesCase.v tb_Gates.v
```

Save your changes and re-run the simulation with :


```
% make compile
% make sim
```

