
module siso_reg #(parameter N=8)
    (
        input clk,        // Clock signal
        input reset,      // Asynchronous reset (active-high)
        input data_in,    // Serial input
        output reg data_out  // Serial output
    );

    // Internal 4-bit shift register
    reg [N-1:0] shift_reg;

    always @(posedge clk or reset) begin
        if (reset) begin
            shift_reg <= 'b0;      // Clear the register on reset, eqv. shift_reg <= {N{'b0}}
            data_out  <= 1'b0;
        end else begin
            // Shift left (MSB is discarded, new bit enters LSB)
            shift_reg <= {shift_reg[N-2:0], data_in};
            // Output the MSB (serial output)
            data_out <= shift_reg[N-1];
        end
    end

endmodule
