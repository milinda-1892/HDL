module dflipflop(
    input wire d,        // Data input
    input wire clk,      // Clock input
    input wire en,       // Enable input
    input wire reset,    // Asynchronous reset input

    output reg q         // Output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0; // Asynchronous reset to 0
        end 
        else if (en) begin
            q <= d; // If enabled, latch the data input on clock edge ('<=' non-blocking assignment)
        end
    end

endmodule