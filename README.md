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
I – The first step is to test the design of a classic full adder, described in VHDL, using the GHDL simulator. This stage allows verification of the circuit’s functional behavior through simulations. After the simulation, the resulting waveforms are viewed with GTKWave, enabling a detailed analysis of the adder’s logical operation (this step is similar to the adder project using the pdk-sky130A);

II – With the adder's functionality verified, the next step is to convert the VHDL code into an equivalent Verilog version. This conversion is essential to enable integration with the backend flow, which mainly operates with designs written in Verilog. The generated Verilog file will serve as input for the physical implementation stage.

III - 
