module fulladder8b(
    input wire [7:0] a,        // First input bit
    input wire [7:0] b,        // Second input bit
    input wire cin,      // Carry input
    output wire [7:0] sum,     // Sum output
    output wire cout     // Carry output
);
    
assign {cout, sum} = a + b + cin; // Calculate sum and carry out
    
endmodule