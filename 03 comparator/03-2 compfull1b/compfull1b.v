module compfull1b(
    input wire a,
    input wire b,
    output reg a_eq_b,
    output reg a_lt_b,
    output reg a_gt_b
    );

    always @(*) begin
        if (a == b) begin
            a_eq_b = 1'b1; // a is equal to b
            a_lt_b = 1'b0; // a is not less than b
            a_gt_b = 1'b0; // a is not greater than b
        end 
        else if (a < b) begin
            a_eq_b = 1'b0; // a is not equal to b
            a_lt_b = 1'b1; // a is less than b
            a_gt_b = 1'b0; // a is not greater than b
        end 
        else begin
            a_eq_b = 1'b0; // a is not equal to b
            a_lt_b = 1'b0; // a is not less than b
            a_gt_b = 1'b1; // a is greater than b
        end
    end
    
endmodule
