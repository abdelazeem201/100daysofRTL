# Objective: To use blocking and nonblocking assignments to describe a counter.

The VeriRISC CPU contains a program counter and a phase counter. One generic counter definition
can serve both purposes

<p align="center">
<img  src="https://user-images.githubusercontent.com/58098260/221982522-d922c5b1-160a-43e4-93f0-4db23320e00d.png">
</p>

# Specifications
* The counter is clocked on the rising edge of clk.
* rst is active high.
* cnt_in and cnt_out are both 5-bit signals.
* If rst is high, output will become zero.
* If load is high, the counter is loaded from the input cnt_in.
* Otherwise, if enab is high, cnt_out is incremented, and cnt_out is unchanged
