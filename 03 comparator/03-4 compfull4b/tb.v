`timescale 1ns/1ps

module IC74LS85_8bit_tb();
    // Test inputs
    reg [7:0] A_8bit;
    reg [7:0] B_8bit;
    
    // Test outputs
    wire A_lt_B_result;
    wire A_eq_B_result;
    wire A_gt_B_result;
    
    // Internal connections for cascading
    wire A_lt_B_cascade;
    wire A_eq_B_cascade;
    wire A_gt_B_cascade;
    
    // Extract lower and upper 4 bits for each input
    wire [3:0] A_lower, A_upper, B_lower, B_upper;
    assign A_lower = A_8bit[3:0];
    assign A_upper = A_8bit[7:4];
    assign B_lower = B_8bit[3:0];
    assign B_upper = B_8bit[7:4];
    
    // Lower 4 bits comparator (less significant)
    IC74LS85 lower_comparator (
        .A(A_lower),
        .B(B_lower),
        // For the least significant stage, we set the cascading inputs
        // according to the 74LS85 datasheet for equality condition:
        .A_lt_B_in(1'b0),
        .A_eq_B_in(1'b1),
        .A_gt_B_in(1'b0),
        // Connect to cascade outputs
        .A_lt_B(A_lt_B_cascade),
        .A_eq_B(A_eq_B_cascade),
        .A_gt_B(A_gt_B_cascade)
    );
    
    // Upper 4 bits comparator (more significant)
    IC74LS85 upper_comparator (
        .A(A_upper),
        .B(B_upper),
        // Cascade from lower stage
        .A_lt_B_in(A_lt_B_cascade),
        .A_eq_B_in(A_eq_B_cascade),
        .A_gt_B_in(A_gt_B_cascade),
        // Final outputs
        .A_lt_B(A_lt_B_result),
        .A_eq_B(A_eq_B_result),
        .A_gt_B(A_gt_B_result)
    );
    
    // Test stimulus
    initial begin
        // Dump waveforms for analysis
        $dumpfile("8bit_comparator.vcd");
        $dumpvars(0, IC74LS85_8bit_tb);
        
        // Test various 8-bit comparison cases
        // Equal values
        A_8bit = 8'h55; B_8bit = 8'h55;
        #10;
        
        // A > B (upper nibble equal, lower nibble different)
        A_8bit = 8'h56; B_8bit = 8'h53;
        #10;
        
        // A < B (upper nibble equal, lower nibble different)
        A_8bit = 8'h42; B_8bit = 8'h47;
        #10;
        
        // A > B (upper nibble different, lower nibble doesn't matter)
        A_8bit = 8'h82; B_8bit = 8'h7F;
        #10;
        
        // A < B (upper nibble different, lower nibble doesn't matter)
        A_8bit = 8'h3F; B_8bit = 8'h41;
        #10;
        
        // Test all bits different
        A_8bit = 8'hAA; B_8bit = 8'h55;
        #10;
        
        // Test border values
        A_8bit = 8'h00; B_8bit = 8'hFF;
        #10;
        A_8bit = 8'hFF; B_8bit = 8'h00;
        #10;
        
        // Test adjacent values
        A_8bit = 8'h80; B_8bit = 8'h7F;
        #10;
        
        // More comprehensive tests
        A_8bit = 8'h12; B_8bit = 8'h34;
        #10;
        A_8bit = 8'hAB; B_8bit = 8'hAB;
        #10;
        A_8bit = 8'hCD; B_8bit = 8'hCE;
        #10;
        
        $display("Test completed");
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time=%0t, A=0x%h, B=0x%h, A<B=%b, A=B=%b, A>B=%b", 
                 $time, A_8bit, B_8bit, A_lt_B_result, A_eq_B_result, A_gt_B_result);
    end
    
endmodule