# Lab 5 Instructions

In this lab we start discussing the FPGA implementation flow and chip details.

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


To create a new Vivado project, either launch 

```
% vivado -mode gui
```

and follow the Project Wizard or type in the Vivado Tcl console

```
Vivado% source ./scripts/project.tcl
```

