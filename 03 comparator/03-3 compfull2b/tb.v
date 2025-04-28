`timescale 1ns/1ps
`include "compfull2b.v"

module tb();
    reg [1:0] a;
    reg [1:0] b;
    wire a_eq_b;
    wire a_gt_b;
    wire a_lt_b;  // Fixed name from a_ls_b to match module port

    compfull2b uut(
        .a(a),
        .b(b),
        .a_eq_b(a_eq_b),
        .a_gt_b(a_gt_b),
        .a_lt_b(a_lt_b)  // Fixed connection from a_ls_b
    );

    initial begin
        // Dump waveform data (for GTKWave)
        $dumpfile("dump.vcd");   // Create a VCD file
        $dumpvars(0, tb);       // Dump all variables

        a = 2'b00; b = 2'b00;
        #10; b = 2'b01;
        #10; b = 2'b10;
        #10; b = 2'b11;

        a = 2'b01; b = 2'b00;
        #10; b = 2'b01;
        #10; b = 2'b10;
        #10; b = 2'b11;

        a = 2'b10; b = 2'b00;
        #10; b = 2'b01;
        #10; b = 2'b10;
        #10; b = 2'b11;

        a = 2'b11; b = 2'b00;
        #10; b = 2'b01;
        #10; b = 2'b10;
        #10; b = 2'b11;

        #10; a = 2'b00; b = 2'b00;
    end

    initial begin
        $monitor("a(%2b), b(%2b), a==b(%1b), a>b(%1b), a<b(%1b)", a, b, a_eq_b, a_gt_b, a_lt_b);
    end

endmodule