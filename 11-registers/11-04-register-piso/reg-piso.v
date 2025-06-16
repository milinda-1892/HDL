module piso_register #(
    parameter WIDTH = 8
) (
    input wire clk,              // Clock input
    input wire reset,             // Active-high reset
    input wire load,              // Load parallel data when high, shift when low
    input wire [WIDTH-1:0] din,   // Parallel data input
    output wire dout              // Serial data output
);

    reg [WIDTH-1:0] shift_reg;    // Shift register
    reg dout_reg;                 // Output register

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= {WIDTH{1'b0}};  // Clear register on reset
            dout_reg <= 1'b0;
        end
        else if (load) begin
            shift_reg <= din;            // Load parallel data
            dout_reg <= din[WIDTH-1];    // Output MSB when loading
        end
        else begin
            shift_reg <= {shift_reg[WIDTH-2:0], 1'b0};  // Shift left
            dout_reg <= shift_reg[WIDTH-1];             // Output MSB
        end
    end

    assign dout = dout_reg;

endmodule