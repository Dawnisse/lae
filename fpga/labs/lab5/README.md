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

Copy the main **Vivado Tcl scripts** under `scripts/` and **Xilinx Design Constraints (XDC)**
for the [**Digilent Arty A7 board**](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)<br/>
under `xdc/` :

```
% cp .solutions/simulation.tcl ./scripts/
% cp .solutions/project.tcl    ./scripts/
% cp .solutions/arty_all.xdc   ./xdc
```


Create a new Verilog RTL source e.g. `rtl/AndOr.v`

```
% gedit rtl/AndOr.v &   (for Linux users)
% npp rtl\AndOr.v       (for Windows users)
```

and implement some basic boolean function, for example :


```verilog
`timescale 1ns / 100ps

module AndOr (

   input wire A,B,C,
   output wire Z

   ) ;

   assign Z = (A & B) | C ;

endmodule
```


**Customize** the provided sample XDC file in order to **map Verilog I/O ports to some physical FPGA pins** :

```
% gedit xdc/arty_all.xdc &    (for Linux users)
% npp xdc\arty_all.xdc        (for Windows users)
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

Load **both the Verilog file and the constraints file** in the newly created project and
try to run from the GUI **all steps of the FPGA implementation flow** :

* generic synthesis (RTL elaboration)
* mapped synthesis
* place-and-route (implementation)
* bitstream generation

