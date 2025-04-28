`timescale 1ps/1ps
`include "compfull1b.v"

module tb ();
    reg a;
    reg b;
    wire a_eq_b;
    wire a_lt_b;
    wire a_gt_b;

    // Instantiate the comparator module
    compfull1b uut (
        .a(a),
        .b(b),
        .a_eq_b(a_eq_b),
        .a_lt_b(a_lt_b),
        .a_gt_b(a_gt_b)
    );

    initial begin
        //Dumpfile
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        a = 1'b0; b = 1'b0; // Test case 1: a = 0, b = 0
        #10; a = 1'b0; b = 1'b1; // Test case 2: a = 0, b = 1
        #10; a = 1'b1; b = 1'b1; // Test case 4: a = 1, b = 1
        #10; a = 1'b1; b = 1'b0; // Test case 3: a = 1, b = 0
        #10; a = 1'b0; b = 1'b0; // Test case 5: a = 0, b = 0
        #10;

    end

    initial begin
        // Monitor the values of a, b, a_eq_b, a_lt_b, and a_gt_b
        $monitor("a = %1b, b = %1b, a_eq_b = %b, a_lt_b = %b, a_gt_b = %b", a, b, a_eq_b, a_lt_b, a_gt_b);

    end

endmodule