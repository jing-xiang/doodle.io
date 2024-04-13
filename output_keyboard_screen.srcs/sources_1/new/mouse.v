module mouse (input rx, output tx,
input clk, 
inout PS2Clk, PS2Data, 
input [6:0] seg, 
input drawer_init,
input [7:0] q,
output [7:0] JB,
output [15:0] led);
//change laterrr
    wire [11:0] value;
    wire toggle = 1;
    wire setx, sety;
    reg[11:0] setmax_x = 96;
    reg[11:0] setmax_y = 64;
    wire [11:0] mouse_x_pos;
    wire [11:0] mouse_y_pos;
    wire mouseL, mouseR, mouseM;
    
    
    wire [15:0] oled_data;
    wire fb;
    wire [12:0] pixel_index;
    wire [6:0] x, y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    wire [15:0] data = 16'h0;
    reg clk_6p25m, clk_25m, clk_12p5m, slow_clk;
    reg[31:0] count_6p25 = (100/12.5) - 1;
    reg[31:0] counter_6p25 = 0;
    reg[31:0] count_25m = (100/50) - 1;
    reg[31:0] counter_25m = 0;
    reg[31:0] count_12p5m = (100/25) - 1;
    reg[31:0] counter_12p5m = 0;
    reg[31:0] slow_count = (100000000/4) - 1;
    reg[31:0] slow_counter = 0;
    reg reset;
    assign led[1] = mouseR;

    always @(posedge clk) begin 
        counter_6p25 <= (counter_6p25 == count_6p25) ? 0 : counter_6p25 + 1;
        clk_6p25m <= (counter_6p25 == 0) ? ~clk_6p25m : clk_6p25m;
        counter_25m <= (counter_25m == count_25m) ? 0 : counter_25m + 1;
        clk_25m <= (counter_25m == 0) ? ~clk_25m : clk_25m;
        counter_12p5m <= (counter_12p5m == count_12p5m) ? 0 : counter_12p5m + 1;
        clk_12p5m <= (counter_12p5m == 0) ? ~clk_12p5m : clk_12p5m;
        slow_counter <= (slow_counter == slow_count) ? 0 : slow_counter + 1;
        slow_clk <= (slow_counter == 0) ? ~slow_clk : slow_clk;
        if (~toggle) begin
            reset <= 1;
        end
        else begin
            reset <= mouseR;
        end
    end
    
    MouseCtl mouse(.clk(clk), .value(value), .setx(setx), .sety(sety),
     .setmax_x(setmax_x), .setmax_y(setmax_y), .ps2_clk(PS2Clk), .ps2_data(PS2Data)
     , .left(mouseL), .right(mouseR), .middle(mouseM), 
     .xpos(mouse_x_pos), .ypos(mouse_y_pos), .rst(reset));
     
     uart_test uart(
              .pixel_index_JC(pixel_index),
              .oled_data_JC(oled_data),    
              .clk_100MHz(clk),
              .rx(rx),
              .tx(tx),
              .q(q)
              );   
         
    Oled_Display screen(.clk(clk_6p25m), .reset(0), 
    .frame_begin(fb), .sending_pixels(), .sample_pixel(),
    .pixel_index(pixel_index), .pixel_data(oled_data), .cs(JB[0]),
    .sdin(JB[1]), .sclk(JB[3]), .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), .pmoden(JB[7]));
   
    paint painter (
    .drawer_init(drawer_init),.mouse_x(mouse_x_pos), .mouse_y(mouse_y_pos), 
    .mouse_l(mouseL), .reset(reset), .enable(toggle), .pixel_index(pixel_index),
    .clk_100M(clk), .clk_25M(clk_25m), .clk_12p5M(clk_12p5m),
     .clk_6p25M(clk_6p25m), .slow_clk(slow_clk),
     .seg(seg), .colour_chooser(oled_data));
    
endmodule