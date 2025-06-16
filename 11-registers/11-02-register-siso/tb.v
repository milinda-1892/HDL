`timescale 1ns/1ps
`include "siso_reg.v"

module tb();
    reg clk, reset, data_in;
    wire data_out;

    // Instantiate the SISO shift register
    siso_reg #(.N(8)) uut(
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Dump waveform data (for GTKWave)
        $dumpfile("dump.vcd");  // Create a VCD file
        $dumpvars(0, tb);       // Dump all variables
    end
    // Stimulus
    initial begin
        reset = 1;  // Apply reset
        data_in = 0;
        #10 reset = 0;  // Release reset

        // Shift in data: 1 → 0 → 1 → 1 (LSB first)
        data_in = 1; #10;  // 1st bit
        data_in = 0; #10;  // 2nd bit
        data_in = 1; #10;  // 3rd bit
        data_in = 1; #10;  // 4th bit
        data_in = 1; #10;  // 1st bit
        data_in = 0; #10;  // 2nd bit
        data_in = 1; #10;  // 3rd bit
        data_in = 1; #10;  // 4th bit
        data_in = 1; #10;  // 1st bit
        data_in = 0; #10;  // 2nd bit
        data_in = 1; #10;  // 3rd bit
        data_in = 1; #10;  // 4th bit

        // Observe output (should be delayed by 4 clocks)
        #20 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t: data_in = %b, data_out = %b, shift_reg = %b", 
                 $time, data_in, data_out, uut.shift_reg);
    end
endmodule