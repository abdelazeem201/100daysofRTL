# Objective: To use a Verilog literal value to describe a parameterized-width bus driver.
The driver output is equal to the input value when  enabled (data_en is true) and is high-impedance
when not enabled (data_en is false).

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221977387-86d0f7d7-56bc-4ebb-a861-88613c15eff9.png">
</p>

# Specifications
* data_in and data_out are both parameterized widths of 8-bit.
* If data_en is high, the input data_in is passed to the output data_out.
* Otherwise, data_out is high impedance.
