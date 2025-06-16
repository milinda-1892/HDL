`timescale 1ns/1ps
`include "reg-piso.v"

module piso_register_tb;

    // Parameters
    parameter WIDTH = 8;
    parameter CLK_PERIOD = 10;

    // Signals
    reg clk;
    reg reset;
    reg load;
    reg [WIDTH-1:0] din;
    wire dout;

    // Instantiate the PISO register
    piso_register #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;

    // Test sequence
   initial begin
        // Initialize inputs
    
        reset = 1; 
        clk = 0;
        load = 0;
        din = 0;
        
        // Reset the register
        #(CLK_PERIOD);
        reset = 0;
        
        // Test case 1: Load and shift
        din = 8'b11110011;
        load = 1;
        #(CLK_PERIOD);
        load = 0;
        
        // Shift out all bits
        repeat(WIDTH) #(CLK_PERIOD) $display("%0t:reset:load:din:dout:%1b:%1b:%8b:%1b", $time, reset, load, din, dout);;
        
        // Test case 2: Load new data and shift
        din = 8'b01101101;
        load = 1;  #(CLK_PERIOD);
        load = 0;
        
        // Shift out all bits
        repeat(WIDTH) #(CLK_PERIOD) $display("%0t:reset:load:din:dout:%1b:%1b:%8b:%1b", $time, reset, load, din, dout);

        // Test case 3: Load new data and shift
        din = 8'b11100111;
        load = 1;
        #(CLK_PERIOD);
        load = 0;
        // Shift out all bits
        repeat(WIDTH/2) #(CLK_PERIOD) $display("%0t:reset:load:din:dout:%1b:%1b:%8b:%1b", $time, reset, load, din, dout);
        reset =1;#(CLK_PERIOD);reset=0;
        // Shift out all bits
        repeat(2) #(CLK_PERIOD) $display("%0t:reset:load:din:dout:%1b:%1b:%8b:%1b", $time, reset, load, din, dout);;
        
        
        // End simulation
        $finish;
    end

    // Monitor the outputs
   // initial begin
        //$monitor("Time = %0t, load = %b, dout = %b, shift_reg = %b", $time, load, dout, uut.shift_reg);
   //     $monitor("%0t:reset:load:din:dout:%1b:%1b:%8b:%1b", $time, reset, load, din, dout);
   // end

endmodule