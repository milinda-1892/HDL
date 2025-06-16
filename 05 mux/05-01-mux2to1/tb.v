`timescale 1ns / 1ps
`include "mux_2to1.v"//lude your mux module

module tb();

    // Inputs
    reg a;
    reg b;
    reg se;
    reg en;

    // Output
    wire y;

    // Instantiate the Unit Under Test (UUT)
    mux_2to1 uut (
        .a(a),
        .b(b),
        .se(se),
        .en(en),
        .y(y)
    );

    initial begin
        // Dump file setup for waveform viewing
        $dumpfile("dump.vcd"); // Create a VCD file for waveform output
        $dumpvars(0, tb); // Dump all variables in the testbench

        // Test vectors
        a = 0; b = 0; se = 0; en = 1; #10;
        a = 0; b = 1; se = 0; en = 1; #10;
        a = 1; b = 0; se = 1; en = 1; #10;
        a = 1; b = 1; se = 1; en = 0; #10;
        a = 0; b = 1; se = 1; en = 1; #10;
        a = 1; b = 0; se = 0; en = 1; #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | a=%b b=%b se=%b en=%b | y=%b", $time, a, b, se, en, y);
    end

endmodule