`timescale 1ns /1 ps
`include "comp1b.v"

module comp1b_tb ;
    reg a;
    reg b;
    wire c;

    // Instantiate the unit under test
    comp1b uut(.a(a), .b(b), .c(c)) ;


    initial begin
      $dumpfile ("dump.vcd") ;
      $dumpvars;

      a = 0; b = 0;
      #10 a = 1; b = 0;
      #10 a = 1; b = 1;
      #10 a = 0; b = 1;
      #10 a = 0; b = 0;
      #10;
    end

    initial begin
      $monitor ("a=%1b b=%1b c=%1b",a,b,c) ;
    end

 endmodule