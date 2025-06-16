`timescale 1ns/1ps
`include "fulladderNb.v"

module tb ();
    parameter N = 16; // Number of bits for the full adder
    reg [N-1:0] a, b; // Input operands
    reg cin; // Carry input
    wire [N-1:0] sum; // Sum output
    wire cout; // Carry output

    integer i; // Loop variable
    integer j; // Loop variable for second operand

    // instatiace the fulladderNb module
    fulladderNb #(.N(N)) uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );


    always @(*) begin

        // test all combinations for small N (e.g. N=4)
        for (i = 0; i < (1<<N); i= i + 1) begin
            for (j = 0; j < (1<<N); j = j + 1) begin
                a = i; // Assign value to a
                b = j; // Assign value to b
                cin = 0; // Set carry input to 0
                #10; // Wait for 10 time units

                // Display the results
                $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);
            end
        end

        a = {N{1'b1}}; // Set a to all 1's
        b = {N{1'b1}}; // Set b to all 1's
        cin = 1; // Set carry input to 1
        #10; // Wait for 10 time units
        // Display the results for all 1's
        $display("a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);

        $finish; // End the simulation
      
    end
endmodule


