module top(
    input wire clk_100MHz,   // Clock Utama
    input wire sw0,          // SW0 (w - Slot Koin)
    input wire btnc,         // BTNC (Tombol Enter/Transisi)
    input wire btnd,         // BTND (Tombol Reset)
    output wire led_y,       // LD0 (Indikator Kopi Keluar)
    output wire [6:0] seg,   // Katoda 7-seg
    output wire [7:0] an     // Anoda 7-seg
);
    wire enter_p, rst_l, y;
    wire [1:0] st;

    debouncer db_e (.clk(clk_100MHz), .btn_in(btnc), .btn_pulse(enter_p), .btn_level());
    debouncer db_r (.clk(clk_100MHz), .btn_in(btnd), .btn_pulse(), .btn_level(rst_l));

    // GANTI "fsm_moore" menjadi "fsm_mealy" SAAT MENDEMOKAN MEALY
    fsm_moore fsm (
        .clk(clk_100MHz), .reset(rst_l), .ce(enter_p), 
        .w(sw0), .y(y), .state_display(st)
    );

    display disp (
        .clk(clk_100MHz), .w_in(sw0), .y_out(y), 
        .state(st), .seg(seg), .an(an)
    );

    assign led_y = y;
endmodule
