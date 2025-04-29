module dlatch1b(
    input wire d,        // Data input
    input wire en,       // Enable input
    output reg q,        // Output

);
      
      always @(en or d) begin
        if (en) begin
            q <= d; // If enabled, latch the data input
        end

      end

endmodule

