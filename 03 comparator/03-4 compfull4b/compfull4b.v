module IC74LS85 (
    // 4-bit inputs to compare
    input [3:0] A,      // 4-bit input A
    input [3:0] B,      // 4-bit input B
    
    // Cascading inputs from less significant stage
    input A_lt_B_in,    // A < B input
    input A_eq_B_in,    // A = B input
    input A_gt_B_in,    // A > B input
    
    // Comparison outputs
    output reg A_lt_B,  // A < B output
    output reg A_eq_B,  // A = B output
    output reg A_gt_B   // A > B output
);

    // Combinational logic for comparison with cascading inputs
    always @(*) begin
        if (A > B) begin
            // A > B, regardless of cascade inputs
            A_gt_B = 1'b1;
            A_eq_B = 1'b0;
            A_lt_B = 1'b0;
        end
        else if (A < B) begin
            // A < B, regardless of cascade inputs
            A_gt_B = 1'b0;
            A_eq_B = 1'b0;
            A_lt_B = 1'b1;
        end
        else begin
            // A = B, result depends on cascade inputs
            A_gt_B = A_gt_B_in;
            A_eq_B = A_eq_B_in;
            A_lt_B = A_lt_B_in;
        end
    end

endmodule