module button_on_a_FSM(
    input wire clk,          // Clock input
    input wire rst,          // Reset input
    input wire button,       // Button input
    output reg y            // Output signal (1 bit)
);
  /*
    reg [1:0] state, nextstate; // 2-bit state register

    // State encoding
    localparam S0 = 2'b00; // State 0: Button not pressed
    localparam S1 = 2'b01; // State 1: Button pressed
    localparam S2 = 2'b10; // State 2: Button released

    // Sequential logic for state transitions
    always @(posedge clk or posedge rst) begin
        if (rst) 
            state <= S0; // Reset to state S0
        else 
            state <= nextstate; // Transition to next state
    end
    
    always @(*) begin
        case (state)
            S0: nextstate = button ? S1 : S0; // Transition to S1 if button pressed
            S1: nextstate = button ? S1 : S2; // Stay in S1 if button pressed, else go to S2
            S2: nextstate = button ? S1 : S0; // Go back to S0 if button not pressed
            default: nextstate = S0; // Default case to avoid latches
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            y <= 0; // Reset output to low
        else 
            y <= (state == S1); // Output is high when in state S1, low otherwise
    end
    */

    parameter LED_ON = 1'b1; // LED on state
    parameter LED_OFF = 1'b0; // LED off state

    parameter STATE_LEDON = 1'b1; // State when LED is on
    parameter STATE_LEDOFF = 1'b0; // State when LED is off

    parameter BTN_PRESSED = 1'b1; // Button pressed state
    parameter BTN_RELEASED = 1'b0; // Button not pressed state



    reg state; // Register to hold LED status

    always @(posedge clk or posedge rst) begin
        if (rst) begin
          y <= LED_OFF; // Reset output to low
          state <= STATE_LEDOFF; // Reset state to LED off
        end
        else 
         case (state)
            STATE_LEDON: begin
                if (button==BTN_RELEASED) begin
                    state <= STATE_LEDOFF; // Transition to LED off state
                    y <= LED_OFF; // Set output to low
                end

            end

            STATE_LEDOFF: begin
                if (button==BTN_PRESSED) begin
                    state <= STATE_LEDON; // Transition to LED on state
                    y <= LED_ON; // Set output to high
                end
            end
            default: begin
                state <= STATE_LEDOFF; // Default case to avoid latches
                y <= LED_OFF; // Set output to low
            end
             

          endcase

    end
            
endmodule

