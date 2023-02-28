# Objective: To use the Verilog case statement to describe a controller.
The controller generates all control signals for the VeriRISC CPU. The operation code, fetch-andexecute phase, and whether the accumulator is zero determine the control signal levels.

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221983938-b20d08b0-ced2-4260-b24d-6be7f76745f7.png">
</p>

# Specifications:
* The controller is clocked on the rising edge of clk.
* rst is synchronous and active high.
* zero is an input which is 1 when the CPU accumulator is zero and 0 otherwise.
* opcode is a 3-bit input for CPU operation, as shown in the following table.

Opcode Instruction  | Opcode Encoding |Operation    | Output      |
--------------------| -------------   |-------------|-------------|
 HLT                | 000             |    PASS A   | in_a => alu_out     |
 SKZ                | 001             |    PASS A   | in_a => alu_out     |
 ADD                | 010             |    ADD      | in_a + in_b => alu_out     |
 AND                | 011             |    AND   | in_a & in_b => alu_out     |
 XOR                | 100             |    XOR   | in_a ^ in_b => alu_out    |
 LDA                | 101             |    PASS B   | in_b => alu_out     |
 STO                | 110             |    PASS A   | in_a => alu_out     |
 JMP                | 111             |    PASS A   | in_a => alu_out     |

* There are 7 single-bit outputs, as shown in this table.

Output    | Function        |
----------| -------------   |
 sel      | select             |   
 rd       | memory read             |    
 ld_ir    | load instruction register             |    
 halt     | halt             |    
 inc_pc   | ncrement program counter            |   
 ld_ac    | load accumulator            |   
 ld_pc    | load program counter             |   
 wr       | memory write            | 
 data_e   |data enable |

The controller has a single-bit phase input with a total of 8 phases processed. Phase
transitions are unconditional, i.e., the controller passes through the same 8-phase
sequence, from INST_ADDR to STORE, every 8 clk cycles. The reset state is
INST_ADDR.

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221985507-14928d0c-1abb-42a7-bb2f-208131d7a02b.png">
</p>

* The controller outputs will be decoded w.r.t phase and opcode, as shown in this table




