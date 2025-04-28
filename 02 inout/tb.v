`timescale 1ns/1ps
`include "mynotgate.v"

module tb();
    reg a; // Kind of a data type, store data
    wire nota;

    mynotgate uut(.a(a), .nota(nota));
    initial begin
      a = 0;
      // Dump waveform data (for GTKWave)
      $dumpfile("dump.vcd");
      $dumpvars(0, tb); // tb name of the module

      #10; a = 1; // will have delay of 10 ns, as timescale is set to nano seconds
      #10; a = 0;
      #10; a = 1;
      #10; a = 0;

    end

    initial begin
        // Monitor continously monitors the signal
        // Expected: a = 0, y = 1
        $monitor("a = %b, not a = %b", a, nota); // %b is a syntax used.
    end

endmodule