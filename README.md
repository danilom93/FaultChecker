# FaultChecker

Design of a self-test module able to perform a self-check of its operation at the power-up of the system performing a comparison of the expected result with the one computed by the system.
The system can be hypothetically adopted on in-car infotainment.
The internal component of the System-on-Chip are:
-ECU: the main control unit of the entire infotainment digital system self-test module;
-Test RAM: RAM memory block storing the results of the test;
-Golden ROM: ROM memory block storing the input patterns and the expected right results;
-Infotainment Core: the Xilinx Logic Core unit.
The design and simulation of the System-on-Chip has been done using VHDL and Xilinx ISE
