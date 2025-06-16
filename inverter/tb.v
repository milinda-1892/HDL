`timescale 1ns / 1ps
`include "inverter.v"

module tb;

    // Testbench signals
    reg [3:0] a;        // Input to DUT (Device Under Test)
    wire [3:0] y;       // Output from DUT
    
    // Test variables
    integer i;          // Loop counter
    integer errors;     // Error counter
    reg [3:0] expected; // Expected output
    
    // Instantiate the Device Under Test (DUT)
    inv uut (
        .a(a),
        .y(y)
    );
    
    // Test procedure
    initial begin
        // Initialize
        $display("===== 4-bit Inverter Testbench =====");
        $display("Time\t Input(a)\t Output(y)\t Expected\t Status");
        $display("----\t --------\t ---------\t --------\t -------");
        
        errors = 0;
        a = 4'b0000;
        
        // Test all possible input combinations (0 to 15)
        for (i = 0; i < 16; i = i + 1) begin
            a = i;                    // Apply input
            expected = ~i;            // Calculate expected output
            #10;                      // Wait 10ns for propagation
            
            // Check result and display
            if (y == expected) begin
                $display("%0t\t %b(%2d)\t %b(%2d)\t %b(%2d)\t PASS", 
                        $time, a, a, y, y, expected, expected);
            end else begin
                $display("%0t\t %b(%2d)\t %b(%2d)\t %b(%2d)\t FAIL", 
                        $time, a, a, y, y, expected, expected);
                errors = errors + 1;
            end
        end
        
        // Summary
        $display("\n===== Test Summary =====");
        if (errors == 0) begin
            $display("✓ ALL TESTS PASSED! (16/16)");
        end else begin
            $display("✗ %0d TESTS FAILED out of 16", errors);
        end
        
        // Additional specific test cases
        $display("\n===== Additional Test Cases =====");
        
        // Test case 1: All zeros
        a = 4'b0000; #10;
        $display("Test 1 - All zeros: a=%b, y=%b, expected=%b %s", 
                a, y, 4'b1111, (y == 4'b1111) ? "PASS" : "FAIL");
        
        // Test case 2: All ones  
        a = 4'b1111; #10;
        $display("Test 2 - All ones:  a=%b, y=%b, expected=%b %s", 
                a, y, 4'b0000, (y == 4'b0000) ? "PASS" : "FAIL");
        
        // Test case 3: Alternating pattern
        a = 4'b1010; #10;
        $display("Test 3 - Alt pattern: a=%b, y=%b, expected=%b %s", 
                a, y, 4'b0101, (y == 4'b0101) ? "PASS" : "FAIL");
        
        // Test case 4: Reverse alternating
        a = 4'b0101; #10;
        $display("Test 4 - Rev alt:     a=%b, y=%b, expected=%b %s", 
                a, y, 4'b1010, (y == 4'b1010) ? "PASS" : "FAIL");
        
        $display("\n===== Testbench Complete =====");
        $finish;
    end
    
    // Monitor changes (optional - can be commented out if too verbose)
    initial begin
        $monitor("At time %0t: a = %b (%0d), y = %b (%0d)", 
                $time, a, a, y, y);
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

endmodule

/*
TESTBENCH EXPLANATION:

1. SIGNAL DECLARATIONS:
   - reg [3:0] a: Input stimulus (driven by testbench)
   - wire [3:0] y: Output from DUT (driven by module)
   - integer i, errors: Loop counter and error tracking

2. DUT INSTANTIATION:
   - Creates instance 'uut' of the 'inv' module
   - Connects testbench signals to module ports

3. TEST PROCEDURE:
   - Tests all 16 possible input combinations (0-15)
   - Calculates expected output using ~i (bitwise NOT)
   - Compares actual vs expected results
   - Reports PASS/FAIL for each test case

4. ADDITIONAL FEATURES:
   - Error counting and summary report
   - Specific test cases for common patterns
   - $monitor for real-time signal tracking
   - VCD file generation for waveform analysis

5. TIMING:
   - Uses #10 delays for signal propagation
   - Sufficient time for combinational logic to settle

TO RUN THIS TESTBENCH:
1. Save both files (inv.v and tb_inv.v) in same directory
2. Compile: iverilog -o inv_sim inv.v tb_inv.v
3. Run: vvp inv_sim
4. View waveforms: gtkwave inv_tb.vcd (if available)
*/