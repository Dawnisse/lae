# Lab 5 Instructions

In this lab we start discussing the **FPGA implementation flow** using Xilinx Vivado.
For this purpose we create a simple **Vivado project** in **graphical mode** to explore
**GUI functionalities** and **FPGA implementation details**.

As a first step, **open a terminal** and go inside the `lab5/` directory :

```
% cd Desktop/lae/fpga/labs/lab5
```

Copy from the `.solutions/` directory the main `Makefile` already prepared for you :


```
% cp .solutions/Makefile .
```

Explore available targets :

```
% make help
```

To create a new fresh working area, type :

```
% make area
```

Finally, copy the main **Vivado Tcl scripts** under `scripts/` :

```
% cp .solutions/simulation.tcl ./scripts/
% cp .solutions/project.tcl ./scripts/
```


Create a new simple Verilog source e.g. `rtl/AndOr.v` `implementing some basic boolean function, for example :

```verilog
`timescale 1ns / 100ps

module AndOr (

   input wire A,B,C,
   output wire Z

   ) ;

   assign Z = (A & B) | C ;

endmodule
```

To create a new **Vivado project**, either launch

```
% vivado -mode gui
```

and follow the **New Project wizard** or type

```
% make project mode=gui
```

at the command line.

Load the Verilog file in the newly created project and try to run from the GUI **all steps of the FPGA implementation flow** :

* RTL elaboration
* synthesis
* place-and-route
* bitstream generation


