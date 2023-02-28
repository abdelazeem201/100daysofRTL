# Objective: To use Verilog operators to describe a parameterized-width arithmetic logic unit (ALU).

ALU performs arithmetic operations on numbers depending upon the operation encoded in the
instruction. This ALU will perform 8 operations on the 8-bit inputs (see table in the Specification)
and generate an 8-bit output and single-bit output.

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221980594-4ee5aa9c-672e-4e25-9a55-3c14172cf866.png">
</p>
# Specifications:

* in_a, in_b, and alu_out are all 8-bit long. The opcode is a 3-bit value for the CPU operation code, as defined in the following table.
* a_is_zero is a single bit asynchronous output with a value of 1 when in_a equals 0. Otherwise, a_is_zero is 0.
* The output alu_out value will depend on the opcode value as per the following table.
* To select which of the 8 operations to perform, you will use opcode as the selection lines.
* The following table states the opcode/instruction, opcode encoding, operation, and output.

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








