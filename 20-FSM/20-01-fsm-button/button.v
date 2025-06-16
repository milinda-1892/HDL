module button
    (   
        input wire reset,
        input wire clk,
        input wire button_in,
        output reg led_status
    );


    //reg stopwatch;
    parameter BTN_PRESSED  = 1;
    parameter BTN_RELEASED = 0;
    parameter LED_ON  = 1'b1;
    parameter LED_OFF = 1'b0;
    
    reg button_status;

    always @ (posedge clk or reset) begin
      if (reset) begin
        led_status <= LED_OFF;
        button_status <= BTN_RELEASED;    
      end
      else if (clear) begin
        led_status <= 1'b0;       
      end
      else begin
        case (button_status)
            BTN_RELEASED: 
                begin
                    if(button_in)  button_status<=BTN_PRESSED;
                    else           led_status <= LED_OFF;

                end
            BTN_PRESSED:
                begin
                    if(!button_in) button_status <= BTN_RELEASED;
                    else           led_status <= LED_ON;

                end
            default: 
                begin
                button_status<=BTN_RELEASED;
                led_status<=LED_OFF;
                end
        
        endcase
      end
    end

endmodule