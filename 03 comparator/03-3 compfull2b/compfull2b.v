module compfull2b(
    input wire [1:0] a,
    input wire [1:0] b,
    output reg a_eq_b, // a = b
    output reg a_gt_b, // a > b
    output reg a_lt_b  // a < b
);

always @(*) begin
    if (a == b) begin
        a_eq_b = 1'b1; a_gt_b = 1'b0; a_lt_b = 1'b0;
    end
    else if(a > b) begin
        a_eq_b = 1'b0; a_gt_b = 1'b1; a_lt_b = 1'b0;
    end
    else begin
        a_eq_b = 1'b0; a_gt_b = 1'b0; a_lt_b = 1'b1;
    end
end

endmodule