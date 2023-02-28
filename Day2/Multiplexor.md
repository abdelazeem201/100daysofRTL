# Objective: To use basic Verilog constructs to describe a simple Multiplexor design.

I create a simple multiplexor design using Verilog constructs and verify it using the
supplied testbench.

I will create the MUX design as per the specification and verify it using the provided testbench.

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221976354-7d761e3f-533d-464c-b81f-68de009040bf.png">
</p>
# Specifications:

* The address multiplexor selects between the instruction address during the instruction
fetch phase and the operand address during the instruction execution phase.
* MUX width is parameterized with the default value of 5.
* If sel is 1’b0, input in0 is passed to the output mux_out.
* If sel is 1’b1, input in1 is passed to the output mux_out
