`timescale 1ns/1ps
`include "fsm-moor.v"

module tb();
    // Inputs
    reg clk;
    reg reset;
    wire y;

    // Outputs
    wire [3:0] count;
    wire overflow;
    
    // Instantiate the Unit Under Test (UUT)
    divideby3FSM uut(   .clk(clk),
                        .reset(reset), 
                        .y(y)
                    );
    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end
    
    // Stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        #20;
        reset = 0;
        #10; #10;#10;#10;#10;#10;#10;#10;#10;#10;#10; 
        #10; #10;#10;#10;#10;#10;#10;#10;#10;#10;#10;
        $finish;   
    end
    
    // Monitor the outputs
    initial begin
        $monitor("Time = %0t %b",  $time, y);
    end
    
    // Generate waveform file for debugging
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end
endmodule