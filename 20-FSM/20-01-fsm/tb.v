`timescale 1ns/1ps
`include "fsm-moor.v"

module tb;

    reg clk;
    reg rst;
    wire y;

    // Instantiate the DUT
    divideby3FSM uut (
        .clk(clk),
        .rst(rst),
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
        $dumpvars(0, tb);

        // Apply reset
        rst = 1;
        #12;
        rst = 0;

        // Run for several clock cycles
        repeat (12) begin
            #10;
            $display("Time=%0t | rst=%b | y=%b", $time, rst, y);
        end

        $finish;
    end

endmodule