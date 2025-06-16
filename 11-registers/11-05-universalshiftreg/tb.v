`timescale 1ns/1ps
`include "usr.v"

module UniversalShiftRegister_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [1:0] S;
    reg [3:0] D;
    reg left_in;
    reg right_in;

    // Outputs
    wire [3:0] Q;

    // Instantiate UUT
    UniversalShiftRegister uut (
        .clk(clk),
        .reset(reset),
        .S(S),
        .D(D),
        .left_in(left_in),
        .right_in(right_in),
        .Q(Q)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        S = 2'b00;
        D = 4'b0000;
        left_in = 0;
        right_in = 0;

        // Release reset after 10ns
        #10 reset = 0;

        // Test Parallel Load (S=11)
        S = 2'b11;
        D = 4'b1101;
        #10 $display("Parallel Load: Q = %b (Expected: 1101)", Q);

        // Test Right Shift (S=01)
        S = 2'b01;
        right_in = 1;
        #10 $display("Right Shift: Q = %b (Expected: 1110)", Q);

        // Test Left Shift (S=10)
        S = 2'b10;
        left_in = 0;
        #10 $display("Left Shift: Q = %b (Expected: 1100)", Q);

        // Test Hold (S=00)
        S = 2'b00;
        #10 $display("Hold: Q = %b (Expected: 1100)", Q);

        // End simulation
        #10 $finish;
    end

endmodule