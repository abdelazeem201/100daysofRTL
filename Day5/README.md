# Objective: To use nonblocking assignments to describe a register.

The VeriRISC CPU contains an accumulator register and an instruction register. One generic register
definition can serve both purposes.

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221981221-6d8002ba-4866-460c-b36b-338158f546d4.png">
</p>

# Specifications
* data_in and data_out are both 8-bit signals.
* rst is synchronous and active high.
* The register is clocked on the rising edge of clk.
* If load is high, the input data is passed to the output data_out.
* Otherwise, the current value of data_out is retained in the register
