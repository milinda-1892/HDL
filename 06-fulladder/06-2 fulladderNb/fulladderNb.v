module fulladderNb #(
    parameter N = 4 // Default bit-width= 4 bits
)

(
    input [N-1:0] a,        // First input
    input [N-1:0] b,        // Second input
    input cin,              // Carry input
    output [N-1:0] sum,     // Sum output
    output cout             // Carry output
);

assign {cout, sum} = a + b + cin; // Calculate sum and carry out

endmodule



    