`timescale 1ps/1ps
`include "fulladder8b.v"

module tb;

    reg [7:0] a, b;
    reg cin;
    wire [7:0] sum;
    wire cout;

    // Instantiate the DUT
    fulladder8b uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Test 1: 0 + 0 + 0
        a = 8'b00000000; b = 8'b00000000; cin = 0;
        #10;
        $display("T1: a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);

        // Test 2: 1 + 1 + 0
        a = 8'b00000001; b = 8'b00000001; cin = 0;
        #10;
        $display("T2: a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);

        // Test 3: 255 + 1 + 0 (overflow)
        a = 8'b11111111; b = 8'b00000001; cin = 0;
        #10;
        $display("T3: a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);

        // Test 4: 128 + 128 + 1
        a = 8'b10000000; b = 8'b10000000; cin = 1;
        #10;
        $display("T4: a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);

        // Test 5: Random values
        a = 8'b01010101; b = 8'b00110011; cin = 1;
        #10;
        $display("T5: a=%b b=%b cin=%b | sum=%b cout=%b", a, b, cin, sum, cout);

        $finish;
        
    end

endmodule