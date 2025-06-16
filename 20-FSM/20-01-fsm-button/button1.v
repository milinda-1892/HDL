module button1 ( 
                    input wire reset, 
                    input wire clk, 
                    input wire button, 
                    output reg led  
                ) ;

    parameter ON  = 1'b1;           
    parameter OFF = 1'b0;

    parameter BTN_PRESSED  = 1'b1;      
    parameter BTN_RELEASAED = 1'b0;
    
    parameter STATE_LED_ON  = 1'b1;      
    parameter STATE_LED_OFF = 1'b0;
    
    reg state;

    always @(posedge clk or reset) begin

        if (reset) 
        begin
            led <= OFF; 
            state<=STATE_LED_OFF;
        end
        
        else 
        begin
            case (state)
                STATE_LED_ON: 
                begin
                    if (button==BTN_RELEASAED) 
                    begin
                        state <= STATE_LED_OFF; 
                        led <= OFF;
                    end
                end

                STATE_LED_OFF: 
                begin
                    if (button==BTN_PRESSED) 
                    begin
                        state <= STATE_LED_ON;  
                        led   <= ON;
                    end
                end
                
                default: 
                begin
                    led   <= OFF;
                    state <= STATE_LED_OFF;
                end
            endcase
        end
    end

endmodule