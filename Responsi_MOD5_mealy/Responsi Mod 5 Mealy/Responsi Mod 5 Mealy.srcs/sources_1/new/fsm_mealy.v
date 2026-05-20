module fsm_mealy(
    input wire clk,
    input wire reset,
    input wire ce,           
    input wire w,            
    output reg y,            
    output wire [1:0] state_display 
);
    parameter S0=2'b00, S1=2'b01;
    reg [1:0] curr, next;

    assign state_display = curr;

    always @(posedge clk or posedge reset) begin
        if (reset) curr <= S0;
        else if (ce) curr <= next;
    end

    // MEALY: Output bergantung pada state SAAT INI dan input W
    always @(*) begin
        next = curr;
        y = 1'b0; 
        
        case (curr)
            S0: begin
                next = (w) ? S1 : S0;
                y = 1'b0;
            end
            S1: begin
                if (w == 1'b1) begin
                    y = 1'b1;   // MEALY: Langsung keluar kopi
                    next = S0;  // State langsung reset ke 00
                end else begin
                    y = 1'b0;
                    next = S1;  
                end
            end
            default: next = S0;
        endcase
    end
endmodule
