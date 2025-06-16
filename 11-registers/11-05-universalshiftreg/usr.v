module UniversalShiftRegister (
    input wire clk,          // Clock signal
    input wire reset,        // Active-high reset
    input wire [1:0] S,      // Control input (S1, S0)
    input wire [3:0] D,      // Parallel data input
    input wire left_in,      // Serial input for left shift
    input wire right_in,     // Serial input for right shift
    output reg [3:0] Q       // Output register
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        Q <= 4'b0000;        // Reset to 0
    end else begin
        case (S)
            2'b00: Q <= Q;                   // Hold (no change)
            2'b01: Q <= {right_in, Q[3:1]};  // Right shift (LSB first)
            2'b10: Q <= {Q[2:0], left_in};   // Left shift (MSB first)
            2'b11: Q <= D;                   // Parallel load
            default: Q <= Q;                // Default case (hold)
        endcase
    end
end

endmodule