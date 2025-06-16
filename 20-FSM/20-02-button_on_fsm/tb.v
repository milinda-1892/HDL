`timescale 1ns/1ps
`include "button.v"

module tb_button_on_a_FSM;

    reg clk;
    reg rst;
    reg button;
    wire y;

    // Instantiate the DUT
    button_on_a_FSM uut (
        .clk(clk),
        .rst(rst),
        .button(button),
        .y(y)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_button_on_a_FSM);

        // Initialize
        rst = 1; button = 0;
        #12;
        rst = 0;

        // Press button (turn LED on)
        #10 button = 1;
        #20 button = 0; // Release button (turn LED off)
        #20 button = 1; // Press again (turn LED on)
        #10 button = 0; // Release (turn LED off)
        #15 button = 1; // Press again
        #10 button = 0; // Release

        // Test reset while button is pressed
        #10 button = 1;
        #5 rst = 1;
        #10 rst = 0;
        #10 button = 0;

        #20 $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | rst=%b | button=%b | y=%b", $time, rst, button, y);
    end

endmodule