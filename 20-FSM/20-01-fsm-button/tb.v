`timescale 1ns/1ps
`include "button.v"

module tb();
    
    reg reset;
    reg clk;
    reg button_in;
    reg clear;

    wire led_status;
    
    // Instantiate the Unit Under Test (UUT)
    button uut
    (   
        .reset(reset),
        .clk(clk),
        .button_in(button_in),
        .clear(clear),
        .led_status(led_status)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    
    // Stimulus
    initial begin
        // Initialize Inputs
        reset = 1; #15; 
        reset = 0; 
        #10;    $display("t=%0t, LED=%b",  $time, led_status);
        #10;    button_in=1'b1;
        #10;    $display("t=%0t, LED=%b",  $time, led_status);
        #10;    button_in=1'b0;
        #10;    $display("t=%0t, LED=%b",  $time, led_status);
        #10;    $display("t=%0t, LED=%b",  $time, led_status);
        #10;    button_in=1'b1;
        #10;    $display("t=%0t, LED=%b",  $time, led_status);
        #10;    $display("t=%0t, LED=%b",  $time, led_status);
        
        $finish;   
    end
    
    // Monitor the outputs
    //initial begin
    //    $monitor("t=%0t, LED=%b",  $time, led_status);
    //end
    
    // Generate waveform file for debugging
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end
endmodule