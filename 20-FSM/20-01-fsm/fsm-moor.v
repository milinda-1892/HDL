module divideby3FSM(
  input wire clk, // Clock input
  input wire rst, // Reset input
  output y // Output signal (1 bit)
);

  reg [1:0] state,nextstate; // 2-bit state register

  // State encoding
  localparam S0 = 2'b00; // State 0
  localparam S1 = 2'b01; // State 1
  localparam S2 = 2'b10; // State 2

  // Sequential logic for state transitions
  always @(posedge clk or posedge rst) begin
    if (rst) 
      state <= S0; 
      else state <= nextstate;// Reset to state S0
    end
    
    always @(*)
      case (state)
        S0: nextstate = S1; // Transition from S0 to S1
        S1: nextstate = S2; // Transition from S1 to S2
        S2: nextstate = S0; // Transition from S2 back to S0
        default: state = S0; // Default case to avoid latches
      endcase
    
  // Output logic
  assign y = (state == S0); // Output is high when in state S0, low otherwise

  endmodule