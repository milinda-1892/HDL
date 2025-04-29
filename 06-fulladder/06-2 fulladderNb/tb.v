`timescale 1ps/1ps
`include "fulladderNb.v"

module tb ();
    wire cout; // Carry output
    integer i, j; // Loop variables

    // instatiace the fulladderNb module
    fulladderNb #(.N(16)) uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );


    always @(*) begin

        // test all combinations for small N (e.g. N=4)
        for (i = 0; i < (1<<N); )
      
    end
