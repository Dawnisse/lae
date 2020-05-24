# Lab 13 Instructions

In this lab with compile and simulate an **8-bit wide, 32-bit deep First-In First-Out (FIFO) memory** using the Xilinx Vivado IP flow.

As a first step, open a terminal and go inside the `lab13/` directory :

```
% cd Desktop/lae/fpga/labs/lab13
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

Additionally, copy from the `.solutions/` directory the following **Tcl simulation and common scripts** :


```
% cp .solutions/scripts/sim/compile.tcl    ./scripts/sim
% cp .solutions/scripts/sim/elaborate.tcl  ./scripts/sim
% cp .solutions/scripts/sim/simulate.tcl   ./scripts/sim
% cp .solutions/scripts/sim/run.tcl        ./scripts/sim

% cp .solutions/scripts/common/init.tcl    ./scripts/common
% cp .solutions/scripts/common/ip.tcl      ./scripts/common
```

In order to **compile the FIFO** lauch the **Vivado IP flow** with :

```
% make ip
```

Select in the **IP Catalog** the **FIFO Generator** available under *Memories & Storage Elements > FIFOs > FIFO Generator*.
Right click on **FIFO Generator** and select **Customize IP...**.

Create a new IP core named `FIFO_WIDTH8_DEPTH32` with the following festures :

* *Common Clock Block RAM* implementation
* 8-bit write/read width
* 32-bit write/read depth
* `8'hFF` output data reset value


Compile the IP and **generate all output products**. Additionally, **export all simulation scripts** by executing in the Tcl console
the following custom Tcl procedure :

```
export_xsim_scripts
```

Inspect source files automatically generated for you in the `cores/FIFO_WIDTH8_DEPTH32/` and `cores/export_scripts/` directories.

Simulation sources and a simple Verilog **wrapper** for the newly generated FIFO have been already prepared for you.
Copy from the `.solutions/` directory the following Verilog sources :

```
% cp .solutions/rtl/FIFO.v        ./rtl/
% cp .solutions/bench/ClockGen.v  ./bench/
% cp .solutions/bench/tb_FIFO.v   ./bench/
```

Compile, elaborate and simulate the design with :

```
% make compile
% make elaborate
% make simulate
```

or simply type

```
% make sim
```

Inspect the waveforms and verify the expected functionality for a FIFO memory.


## Further readings

If you are interested in more in-depth details about the Xilinx Vivado **FIFO Generator** you can refer to :

* [*FIFO Generator v13.1 LogiCORE IP Product Guide*](https://www.xilinx.com/support/documentation/ip_documentation/fifo_generator/v13_1/pg057-fifo-generator.pdf)
* [*FIFO Generator v13.2 LogiCORE IP Product Guide*](https://www.xilinx.com/support/documentation/ip_documentation/fifo_generator/v13_2/pg057-fifo-generator.pdf)


<hr>

**IMPORTANT**

Since Vivado 2017.x the IP now uses version **v13.2** of the FIFO Generator instead of **v13.1** !

<hr>

