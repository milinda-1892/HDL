`timescale 1ns/1ps
`include "reg-sipo.v"

module sipo_register_tb;

    // Parameters
    parameter WIDTH = 8;
    parameter CLK_PERIOD = 10; // 10 ns clock period
    
    // Signals
    reg clk;
    reg reset;
    reg serial_in;
    wire [WIDTH-1:0] parallel_out;
    
    // Instantiate the SIPO register
    sipo_register #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parallel_out(parallel_out)
    );
    
    // Clock generation
    /*always begin
        clk = 1'b0;
        #(CLK_PERIOD/2);
        clk = 1'b1;
        #(CLK_PERIOD/2);
    end*/
        initial begin
        clk <= 0;
        forever begin
            #(CLK_PERIOD/2); clk <= ~clk;
            end
        end
    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1'b1;
        serial_in = 1'b0;
        
        // Apply reset
        #(CLK_PERIOD*2);
        reset = 1'b0;
        
        // Shift in data: 10110011 (LSB first)
        serial_in = 1'b1; #CLK_PERIOD; // Bit 0
        serial_in = 1'b1; #CLK_PERIOD; // Bit 1
        serial_in = 1'b0; #CLK_PERIOD; // Bit 2
        serial_in = 1'b0; #CLK_PERIOD; // Bit 3
        serial_in = 1'b1; #CLK_PERIOD; // Bit 4
        serial_in = 1'b1; #CLK_PERIOD; // Bit 5
        serial_in = 1'b0; #CLK_PERIOD; // Bit 6
        serial_in = 1'b1; #CLK_PERIOD; // Bit 7
        
        // Check output (should be 11001101)
        #1;
        if (parallel_out === 8'b11001101)
            $display("Test passed! Output: %b", parallel_out);
        else
            $display("Test failed! Expected 11001101, got %b", parallel_out);
        
        // End simulation
        //
        $finish;
    end
    
endmodule