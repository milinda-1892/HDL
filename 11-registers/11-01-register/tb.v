`timescale 1ns/1ps
`include "pipo_reg.v"

module tb;

    // Parameters
    localparam WIDTH = 8;
    localparam CLK_PERIOD = 10;
    
    // Signals
    reg clk;
    reg reset;
    reg load;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;
    
    // Instantiate the PIPO register
    pipo_reg #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;
    
    initial begin
        // Dump waveform data (for GTKWave)
        $dumpfile("dump.vcd");  // Create a VCD file
        $dumpvars(0, tb);       // Dump all variables
    end
    // Test procedure
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        load = 0;
        data_in = 0;
        
        // Apply reset
        #20 reset = 0;
        
        // Test load operation
        #10 data_in = 8'hAA; load = 1;
        #10 load = 0;
        
        // Test another load
        #20 data_in = 8'h55; load = 1;
        #10 load = 0;
        
        // Test without load
        #20 data_in = 8'hFF;
        
        // End simulation
        #50 $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time = %0t, clk = %b, reset = %b, load = %b, data_in = %h, data_out = %h",
                 $time, clk, reset, load, data_in, data_out);
    end

endmodule