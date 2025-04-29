module fulladder1b(
    input wire a,        // First input bit
    input wire b,        // Second input bit
    input wire cin,      // Carry input
    output wire sum,     // Sum output
    output wire cout     // Carry output
);
    
assign {cout, sum} = a + b + cin; // Calculate sum and carry out
    
endmodule