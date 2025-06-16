module sipo_register #(
    parameter WIDTH = 8
) (
    input wire clk,          // Clock input
    input wire reset,        // Active-high reset
    input wire serial_in,    // Serial data input
    output reg [WIDTH-1:0] parallel_out  // Parallel data output
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all bits to 0
        parallel_out <= {WIDTH{1'b0}};
    end else begin
        // Shift left and insert new bit at LSB
        parallel_out <= {parallel_out[WIDTH-2:0], serial_in};
    end
end

endmodule