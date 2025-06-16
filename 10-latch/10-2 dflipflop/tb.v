`timescale 1ns/1ps
`include "dflipflop.v"

module tb();
    // Testbench signals
    reg d;          // Data input
    reg clk;        // Clock input
    reg en;         // Enable input
    reg reset;      // Reset input
    wire q;         // Output from DUT
    
    // Instantiate the Device Under Test (DUT)
    dflipflop uut(
        .d(d),
        .clk(clk),
        .en(en),
        .reset(reset),
        .q(q)
    );
    
    initial begin
        $dumpfile("dump.vcd"); // Create a VCD file for waveform viewing
        $dumpvars(0, tb); // Dump all variables for waveform viewing
    end

    // Clock generation
    initial begin
        clk <= 0;
        forever begin
            #5 clk = ~clk; // Toggle clock every 5ns (100MHz)
        end 
    end
    
    // Monitor signals (moved out of the test sequence initial block)
    initial begin
        $monitor("t=%3d: d=%b, clk=%b, en=%b, reset=%b, q=%b", $time, d, clk, en, reset, q);
    end

    // Test sequence
    initial begin
        // Initialize inputs
        d = 0;
        en = 0;
        reset = 1; // Start with reset active
        
        // Release reset after 20ns
        #20 reset = 0;
        
        // Test case 1: Enable is low, d changes should not affect q
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;
        
        // Test case 2: Enable high, d changes should be reflected in q on clock edges
        #10 en = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 0;
        
        // Test case 3: Disable enable, d changes should not affect q
        #10 en = 0;
        #10 d = 1;
        #10 d = 0;
        
        // Test case 4: Test asynchronous reset while running
        #10 en = 1;
        #10 d = 1;
        #5 reset = 1; // Assert reset asynchronously
        #10 reset = 0; // Release reset
        
        // Test case 5: Final tests
        #10 d = 1;
        #10 en = 0;
        #10 d = 0;
        #10 en = 1;
        
        // End simulation after 200ns
        #10 $finish;
    end
    
endmodule