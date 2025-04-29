`timescale 1ps/1ps
`include "fulladder1b.v"

module tb ();
    reg a;        // First input bit
    reg b;        // Second input bit
    reg cin;      // Carry input
    wire sum;     // Sum output
    wire cout;    // Carry output

    // Instantiate the full adder module
    fulladder1b uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        //Dumpfile
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
        
        a = 1'b0; b = 1'b0; cin = 1'b0; #10; // Test case 1: a = 0, b = 0, cin = 0
        a = 1'b0; b = 1'b0; cin = 1'b1; #10; // Test case 2: a = 0, b = 0, cin = 1
        a = 1'b0; b = 1'b1; cin = 1'b0; #10; // Test case 3: a = 0, b = 1, cin = 0
        a = 1'b0; b = 1'b1; cin = 1'b1; #10; // Test case 4: a = 0, b = 1, cin = 1

        a = 1'b1; b = 1'b0; cin = 1'b0; #10; // Test case 5: a = 1, b = 0, cin = 0
        a = 1'b1; b = 1'b0; cin = 1'b1; #10; // Test case 6: a = 1, b = 0, cin = 1
        a = 1'b1; b = 1'b1; cin = 1'b0; #10; // Test case 7: a = 1, b = 1, cin = 0
        a = 1'b1; b = 1'b1; cin = 1'b1; #10; // Test case 8: a = 1, b = 1, cin = 1


    end

    initial begin

        // Test all combinations of inputs
        $monitor("Time: %0t | a: %b | b: %b | cin: %b | sum: %b | cout: %b", $time, a, b, cin, sum, cout);
    end

endmodule