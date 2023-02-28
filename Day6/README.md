# Objective: To use continuous and procedural assignments to describe a memory.
The VeriRISC CPU uses the same memory for instructions and data. The memory has a single
bidirectional data port and separate write and read control inputs. It cannot perform simultaneous
write and read operations.

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221981570-5748981f-c04b-482c-9f8b-11348ee4dfa3.png">
</p>

# Specifications
* addr is parameterized to 5 and data is parameterized to 8.
* wr (write) and rd (read) are single-bit input signals.
* The memory is clocked on the rising edge of clk.
* Analyze the memory read and write operation timing diagram, as shown in the following graphic.
* Memory write: data_in is written to memory[addr] on the positive edge of clk when wr (write) =1.
<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221981953-7e09308f-a343-46ab-9d01-442d8d1ecc31.png">
</p>
* Memory read: data_out is assigned from memory[addr] when rd (read) =1.
<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221982048-54ecd7c9-bdf5-4b80-8c43-fea58635fd82.png">
</p>
