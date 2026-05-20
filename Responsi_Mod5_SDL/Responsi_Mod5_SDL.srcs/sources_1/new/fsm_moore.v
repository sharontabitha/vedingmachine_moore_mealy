module fsm_moore(
    input wire clk,
    input wire reset,
    input wire ce,           // Tombol Enter
    input wire w,            // Switch Koin
    output reg y,            // Output Kopi Keluar
    output wire [1:0] state_display 
);
    parameter S0=2'b00, S1=2'b01, S2=2'b10;
    reg [1:0] curr, next;

    assign state_display = curr;

    always @(posedge clk or posedge reset) begin
        if (reset) curr <= S0;
        else if (ce) curr <= next;
    end

    // MOORE: Output HANYA bergantung pada state saat ini
    always @(*) begin
        y = (curr == S2) ? 1'b1 : 1'b0; 
        
        case (curr)
            S0: next = (w) ? S1 : S0; // Tunggu koin 1
            S1: next = (w) ? S2 : S1; // Tunggu koin 2
            S2: next = (w) ? S1 : S0; // Kopi keluar, reset jika w=0, atau lanjut koin baru jika w=1
            default: next = S0;
        endcase
    end
endmodule
