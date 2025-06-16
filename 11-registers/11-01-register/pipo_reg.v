/*
 * Parallel Input Parallel Output Register
 * Width (Num Of Bits) is Parameterized
 */
module pipo_reg #(parameter WIDTH = 8) 
    (
        input wire clk,          // Clock input
        input wire reset,        // Active-high reset
        input wire load,         // Load enable signal
        input wire [WIDTH-1:0] data_in,  // Parallel data input
        output reg [WIDTH-1:0] data_out  // Parallel data output
    );

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all bits to 0
        data_out <= {WIDTH{1'b0}};
    end
    else if (load) begin
        // Load new data on rising clock edge when load is high
        data_out <= data_in;
    end
    // If load is low, data_out retains its value
end

endmodule