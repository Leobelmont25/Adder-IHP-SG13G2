# Adder-IHP-SG13G2
Implementation of a VHDL adder to test a full digital flow using open source tools with PDK-IHP-SG13G2. The project is developed in a WSL (Windows Subsystem for Linux) environment and covers both high-level simulation (GHDL + GTKWave) and physical synthesis (Klayout) of the circuit.
The Docker image used for this project is available in the "image" file
```bash
// After downloading the docker image, you must open the WSL terminal and run the following command:
$ docker build -t dockerfile .
// After After installing the entire image, use:
$ docker run -it dockerfile
````
------

# Defining Actions
I – The first step is to test the design of a classic full adder, described in VHDL, using the GHDL simulator. This stage allows verification of the circuit’s functional behavior through simulations. After the simulation, the resulting waveforms are viewed with GTKWave, enabling a detailed analysis of the adder’s logical operation (this step is similar to the adder project using the pdk-sky130A: https://github.com/Leobelmont25/Adder);

II – With the adder's functionality verified, the next step is to convert the VHDL code into an equivalent Verilog version. This conversion is essential to enable integration with the backend flow, which mainly operates with designs written in Verilog. The generated Verilog file will serve as input for the physical implementation stage.

III - Next, the process of Floorplanning + Placement + CTS + Routing takes as input the netlist (logical circuit) and LEF files (physical descriptions of the cells) to generate a DEF file containing the complete and routed layout of the chip. It defines the chip’s organization, places the cells, inserts clock buffers (CTS), and connects all signals with physical routing tracks.

IV - The Physical Verification stage, performed using DRC and LVS in KLayout, ensures the correctness and manufacturability of the chip layout. The Design Rule Check (DRC) validates that the layout complies with the specific geometric and spacing rules required by the fabrication process. Meanwhile, the Layout Versus Schematic (LVS) check compares the extracted netlist from the physical layout to the original logical netlist to confirm that the implemented design matches the intended circuit functionality. These steps are essential to detect and prevent physical and logical errors before tape-out.

V -After the DRC and LVS checks are successfully passed, the final step is the generation of the GDSII file, which is done using KLayout. The GDSII file is the standard format used to represent the physical layout of the chip and is sent to the semiconductor foundry for fabrication. It contains all the geometric information about the chip’s layers, shapes, and structures, making it the final representation of the design ready for manufacturing.

--------
# Simulations

# 1. VHDL Adder - Simulation and Verification using GHDL + GTKWave

This project demonstrates the simulation and verification of a VHDL adder using open-source tools such as **GHDL** and **GTKWave**. Below are described the steps to perform the analysis, simulation and visualization of the waveforms.
Follow the steps to create the project files in the correct locations and avoid runtime errors.
```bash

/opt/OpenROAD-flow-scripts# cd flow
make
// After finishing running "make", create a folder for your project:
mkdir teste1
cd teste1
// Then create your files
````
---

## 🛠️ Prerequisite

Make sure you have the following tools installed in your environment (preferably via WSL):

- [GHDL](https://ghdl.readthedocs.io)
- [GTKWave](http://gtkwave.sourceforge.net)

---
## 📁 Project Structure

Run the following commands to analyze the VHDL source files:

```bash

ghdl -a full_adder.vhdl
ghdl -a adder.vhdl

// Testbenches Analysis
ghdl -a full_adder_tb.vhdl
ghdl -a adder_tb.vhdl

// Preparation of Test Units
ghdl -e full_adder_tb
ghdl -e adder_tb

// Running Simulations and Generating Waveforms
ghdl -r full_adder_tb --wave=full_adder_tb.ghw
ghdl -r adder_tb --wave=adder_tb.ghw

```
# Viewing Waveforms

Open the .ghw files in GTKWave to inspect the simulated signals:
```bash

gtkwave full_adder_tb.ghw
gtkwave adder_tb.ghw
````
# Screenshot
![image](https://github.com/user-attachments/assets/c603ad7f-40b7-4a49-9706-3b7941d591e9)

# 🔄 2. VHDL to Verilog

This document describes the process of converting a project written in VHDL to Verilog using open-source tools.
---

## 📋 Requirements

- [Yosys](https://yosyshq.net/yosys/)
- [GHDL](https://ghdl.github.io/ghdl/)

---

## ⚙️ Procedures

### 🔹 full_adder

```bash
yosys -m ghdl -p 'ghdl full_adder.vhdl -e full_adder; write_verilog full_adder.v'
````
### 🔹 adder

```bash
yosys -m ghdl -p 'ghdl adder.vhdl -e full_adder; write_verilog adder.v'
````

# Screenshot
![image](https://github.com/user-attachments/assets/f29f32bd-7093-4342-b5c8-07db25bf19f5)
