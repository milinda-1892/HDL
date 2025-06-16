///`timescale 1ns/1ps
`include "button1.v"

module tb();
    
    reg reset;
    reg clk;
    reg button;
    wire led;

    wire led_status;
    
    // Instantiate the Unit Under Test (UUT)
    button1 uut (   .reset(reset), 
                    .clk(clk), 
                    .button(button), 
                    .led(led)  
                ) ;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    
    // Stimulus
    initial begin
        // Initialize Inputs
        reset = 1; 
        #3; 
        reset = 0; 
        #10    button=1'b1;
               $display("t=%0t, BUTTON=%b, LED=%b",  $time, button, led);
        #10    $display("t=%0t, BUTTON=%b, LED=%b",  $time, button, led);
        #10    $display("t=%0t, BUTTON=%b, LED=%b",  $time, button, led);
        #10    button=1'b0;
        #10    $display("t=%0t, BUTTON=%b, LED=%b",  $time, button, led);
        #10    $display("t=%0t, BUTTON=%b, LED=%b",  $time, button, led);
        #10    button=1'b1;
        #10    $display("t=%0t, BUTTON=%b, LED=%b",  $time, button, led);
        #10    $display("t=%0t, BUTTON=%b, LED=%b",  $time, button, led);
        
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