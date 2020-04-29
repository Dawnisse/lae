# Run the test flow

A small simulation example is provided to **test your environment setup** and **tools installation**.<br/>
A simple GNU `Makefile` can be used to automate the flow.

To run the test flow, **open a terminal** and go inside the `test/` directory :


```
% cd Desktop/lae/fpga/test
```

List the content of the `test/` directory :

```
% ls -l
```


List all available `Makefile` targets with :

```
% make help
```

Compile the example Verilog file `test.v` and run the simulation with :

```
% make compile
% make sim
```

Explore the **Xilinx XSim simulator** graphical interface. Once happy, close the window.

To delete all log files and other temporary files :

```
% make clean
```

Explore the content of provided files using basic Linux commands, e.g. `cat`, `less` or `more` :

```
% cat test.v
% cat Makefile
% cat run.tcl
```
