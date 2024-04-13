`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2024 11:42:55 AM
// Design Name: 
// Module Name: keyboard_input
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module keyboard_input(
    input guess_init,
    input btnR,
    input [5:0] game_time,
    input [7:0] q, 
    input clk, 
    input PS2Data, 
    input PS2Clk, 
    //output reg [15:0] //led, 
    output reg [7:0]ow_0, output reg [7:0]ow_1,
    output reg [7:0]ow_2, output reg [7:0]ow_3,
    output reg [7:0]ow_4, output reg [7:0]ow_5,
    output reg [7:0]ow_6, output reg [7:0]ow_7,
    output reg [7:0]ow_8, output reg [7:0]ow_9,
    
    output reg [7:0]tw_0, output reg [7:0]tw_1,
    output reg [7:0]tw_2, output reg [7:0]tw_3,
    output reg [7:0]tw_4, output reg [7:0]tw_5,
    output reg [7:0]tw_6, output reg [7:0]tw_7,
    output reg [7:0]tw_8, output reg [7:0]tw_9,
    output reg [1:0] correct_word,
    output reg [15:0] colour);

// correct_word is for colour changing
// corre
    parameter [15:0] WHITE = 16'b1111111111111111;
    parameter [15:0] BLACK = 16'd0;
    parameter [15:0] RED = 16'b1111100000000000;
    parameter [15:0] GREEN = 16'b0000011111100000;
    
    wire [15:0] keycode;
    reg [23:0] compiled = 24'b0;
    reg [7:0] words [0:9];
    reg [7:0] target_first_letter, target_second_letter, target_third_letter;
    reg [7:0] target_word[0:9];
    integer i;
    wire oflag;
    reg [3:0] word_length = 4'b11;
    reg [3:0] current_word_length = 4'b0;
    
    wire [7:0]A = 8'h1C;
    wire [7:0]B = 8'h32;
    wire [7:0]C = 8'h21;
    wire [7:0]D = 8'h23;
    wire [7:0]E = 8'h24;
    wire [7:0]F = 8'h2B;
    wire [7:0]G = 8'h34;
    wire [7:0]H = 8'h33;
    wire [7:0]I = 8'h43;
    wire [7:0]J = 8'h3B;
    wire [7:0]K = 8'h42;
    wire [7:0]L = 8'h4B;
    wire [7:0]M = 8'h3A;
    wire [7:0]N = 8'h31;
    wire [7:0]O = 8'h44;
    wire [7:0]P = 8'h4D;
    wire [7:0]Q = 8'h15;
    wire [7:0]R = 8'h2D;
    wire [7:0]S = 8'h1B;
    wire [7:0]T = 8'h2C;
    wire [7:0]U = 8'h3C;
    wire [7:0]V = 8'h2A;
    wire [7:0]W = 8'h1D;
    wire [7:0]X = 8'h22;
    wire [7:0]Y = 8'h35;
    wire [7:0]Z = 8'h1A;
    wire [7:0]space = 8'h29;

    
    initial begin  
        //led = 16'b0;
        words[0] = 8'h0;
        words[1] = 8'h0;
        words[2] = 8'h0;
        words[3] = 8'h0;
        words[4] = 8'h0;
        words[5] = 8'h0;
        words[6] = 8'h0;
        words[7] = 8'h0;
        words[8] = 8'h0;
        words[9] = 8'h0;
        // target_word[0] = 8'h24;
        // target_word[1] = 8'h4B;
        // target_word[2] = 8'h24;
        // target_word[3] = 8'h4D;
        // target_word[4] = 8'h33;
        // target_word[5] = 8'h1C;
        // target_word[6] = 8'h31;
        // target_word[7] = 8'h2C;

        target_word[0] = 8'h0;
        target_word[1] = 8'h0;
        target_word[2] = 8'h0;
        target_word[3] = 8'h0;
        target_word[4] = 8'h0;
        target_word[5] = 8'h0;
        target_word[6] = 8'h0;
        target_word[7] = 8'h0;
        target_word[8] = 8'h0;
        target_word[9] = 8'h0;
    end
    
//    integer temp;
//    initial begin
//        for (temp = 0; temp < 10; i = i+1) begin
//            if (target_word[temp] != 8'h0) begin
//                tw_length = tw_length + 1;
//            end
//        end
//    end
    always @(posedge clk) begin
        case(q)
            
        
                    8'd1 : begin //ant
                        word_length = 4'b11;
                        target_word[0] = A;//8'h1C;
                        target_word[1] = N;//8'h31;
                        target_word[2] = T;//8'h2C;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd2 : begin //bat
                        word_length = 4'b11;
                        target_word[0] = B;
                        target_word[1] = A;
                        target_word[2] = T;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd3 : begin //bear
                        word_length = 4'b100;
                        target_word[0] = B;
                        target_word[1] = E;
                        target_word[2] = A;
                        target_word[3] = R;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd4 : begin //bee
                        word_length = 4'b11;
                        target_word[0] = B;
                        target_word[1] = E;
                        target_word[2] = E;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd5 : begin //bird
                        word_length = 4'b100;
                        target_word[0] = B;
                        target_word[1] = I;
                        target_word[2] = R;
                        target_word[3] = D;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd6 : begin //butterfly
                        word_length = 4'b1001;
                        target_word[0] = B;
                        target_word[1] = U;
                        target_word[2] = T;
                        target_word[3] = T;
                        target_word[4] = E;
                        target_word[5] = R;
                        target_word[6] = F;
                        target_word[7] = L;
                        target_word[8] = Y;
                        target_word[9] = 0;
                    end
                    8'd7 : begin //camel
                        word_length = 4'b101;
                        target_word[0] = C;
                        target_word[1] = A;
                        target_word[2] = M;
                        target_word[3] = E;
                        target_word[4] = L;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd8 : begin //cat
                        word_length = 4'b11;
                        target_word[0] = C;
                        target_word[1] = A;
                        target_word[2] = T;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd9 : begin //cow
                        word_length = 4'b11;
                        target_word[0] = C;
                        target_word[1] = O;
                        target_word[2] = W;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd10 : begin //crab
                        word_length = 4'b100;
                        target_word[0] = C;
                        target_word[1] = R;
                        target_word[2] = A;
                        target_word[2] = B;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd11 : begin //crocodile
                        word_length = 4'b1001;
                        target_word[0] = C;
                        target_word[1] = R;
                        target_word[2] = O;
                        target_word[3] = C;
                        target_word[4] = O;
                        target_word[5] = D;
                        target_word[6] = I;
                        target_word[7] = L;
                        target_word[8] = E;
                        target_word[9] = 0;
                    end
                    8'd12 : begin //dog
                        word_length = 4'b11;
                        target_word[0] = D;
                        target_word[1] = O;
                        target_word[2] = G;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd13 : begin //dolphin
                        word_length = 4'b111;
                        target_word[0] = D;
                        target_word[1] = O;
                        target_word[2] = L;
                        target_word[3] = P;
                        target_word[4] = H;
                        target_word[5] = I;
                        target_word[6] = N;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd14 : begin //dragon
                        word_length = 4'b110;
                        target_word[0] = D;
                        target_word[1] = R;
                        target_word[2] = A;
                        target_word[3] = G;
                        target_word[4] = O;
                        target_word[5] = N;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd15 : begin //DUCK
                        word_length = 4'b100;
                        target_word[0] = D;
                        target_word[1] = U;
                        target_word[2] = C;
                        target_word[2] = K;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd16 : begin //ELEPHANT
                        word_length = 4'b1000;
                        target_word[0] = E;
                        target_word[1] = L;
                        target_word[2] = E;
                        target_word[3] = P;
                        target_word[4] = H;
                        target_word[5] = A;
                        target_word[6] = N;
                        target_word[7] = T;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd17 : begin //FISH
                        word_length = 4'b100;
                        target_word[0] = F;
                        target_word[1] = I;
                        target_word[2] = S;
                        target_word[2] = H;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd18 : begin //FLAMINGO
                        word_length = 4'b1000;
                        target_word[0] = F;
                        target_word[1] = L;
                        target_word[2] = A;
                        target_word[3] = M;
                        target_word[4] = I;
                        target_word[5] = N;
                        target_word[6] = G;
                        target_word[7] = O;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd19 : begin //FROG
                        word_length = 4'b100;
                        target_word[0] = F;
                        target_word[1] = R;
                        target_word[2] = O;
                        target_word[2] = G;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd20 : begin //GIRAFFE
                        word_length = 4'b111;
                        target_word[0] = G;
                        target_word[1] = I;
                        target_word[2] = R;
                        target_word[3] = A;
                        target_word[4] = F;
                        target_word[5] = F;
                        target_word[6] = E;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd21 : begin //HEDGEHOG
                        word_length = 4'b1000;
                        target_word[0] = H;
                        target_word[1] = E;
                        target_word[2] = D;
                        target_word[3] = G;
                        target_word[4] = E;
                        target_word[5] = H;
                        target_word[6] = O;
                        target_word[7] = G;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd22 : begin //HORSE
                        word_length = 4'b101;
                        target_word[0] = H;
                        target_word[1] = O;
                        target_word[2] = R;
                        target_word[3] = S;
                        target_word[4] = E;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd23 : begin //KANGAROO
                        word_length = 4'b1000;
                        target_word[0] = K;
                        target_word[1] = A;
                        target_word[2] = N;
                        target_word[3] = G;
                        target_word[4] = A;
                        target_word[5] = R;
                        target_word[6] = O;
                        target_word[7] = O;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd24 : begin //LION
                        word_length = 4'b100;
                        target_word[0] = L;
                        target_word[1] = I;
                        target_word[2] = O;
                        target_word[2] = N;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd25 : begin //LOBSTER
                        word_length = 4'b111;
                        target_word[0] = L;
                        target_word[1] = O;
                        target_word[2] = B;
                        target_word[3] = S;
                        target_word[4] = T;
                        target_word[5] = E;
                        target_word[6] = R;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd26 : begin //MERMAID
                        word_length = 4'b111;
                        target_word[0] = M;
                        target_word[1] = E;
                        target_word[2] = R;
                        target_word[3] = M;
                        target_word[4] = A;
                        target_word[5] = I;
                        target_word[6] = D;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd27 : begin //MONKEY
                        word_length = 4'b110;
                        target_word[0] = M;
                        target_word[1] = O;
                        target_word[2] = N;
                        target_word[3] = K;
                        target_word[4] = E;
                        target_word[5] = Y;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd28 : begin //MOSQUITO
                        word_length = 4'b1000;
                        target_word[0] = M;
                        target_word[1] = O;
                        target_word[2] = S;
                        target_word[3] = Q;
                        target_word[4] = U;
                        target_word[5] = I;
                        target_word[6] = T;
                        target_word[7] = O;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd29 : begin //MOUSE
                        word_length = 4'b101;
                        target_word[0] = M;
                        target_word[1] = O;
                        target_word[2] = U;
                        target_word[3] = S;
                        target_word[4] = E;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd30 : begin //OCTOPUS
                        word_length = 4'b111;
                        target_word[0] = O;
                        target_word[1] = C;
                        target_word[2] = T;
                        target_word[3] = O;
                        target_word[4] = P;
                        target_word[5] = U;
                        target_word[6] = S;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd31 : begin //OWL
                        word_length = 4'b11;
                        target_word[0] = O;
                        target_word[1] = W;
                        target_word[2] = L;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd32 : begin //PANDA
                        word_length = 4'b101;
                        target_word[0] = P;
                        target_word[1] = A;
                        target_word[2] = N;
                        target_word[3] = D;
                        target_word[4] = A;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd33 : begin //PARROT
                        word_length = 4'b110;
                        target_word[0] = P;
                        target_word[1] = A;
                        target_word[2] = R;
                        target_word[3] = R;
                        target_word[4] = O;
                        target_word[5] = T;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd34 : begin //PENGUIN
                        word_length = 4'b111;
                        target_word[0] = P;
                        target_word[1] = E;
                        target_word[2] = N;
                        target_word[3] = G;
                        target_word[4] = U;
                        target_word[5] = I;
                        target_word[6] = N;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd35 : begin //PIG
                        word_length = 4'b11;
                        target_word[0] = P;
                        target_word[1] = I;
                        target_word[2] = G;
                        target_word[3] = 0;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd36 : begin //RABBIT
                        word_length = 4'b110;
                        target_word[0] = R;
                        target_word[1] = A;
                        target_word[2] = B;
                        target_word[3] = B;
                        target_word[4] = I;
                        target_word[5] = T;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd37 : begin //RACCOON
                        word_length = 4'b111;
                        target_word[0] = R;
                        target_word[1] = A;
                        target_word[2] = C;
                        target_word[3] = C;
                        target_word[4] = O;
                        target_word[5] = O;
                        target_word[6] = N;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd38 : begin //RHINOCEROS
                        word_length = 4'b1010;
                        target_word[0] = R;
                        target_word[1] = H;
                        target_word[2] = I;
                        target_word[3] = N;
                        target_word[4] = O;
                        target_word[5] = C;
                        target_word[6] = E;
                        target_word[7] = R;
                        target_word[8] = O;
                        target_word[9] = S;
                    end
                    8'd39 : begin //Scorpion
                        word_length = 4'b1000;
                        target_word[0] = S;
                        target_word[1] = C;
                        target_word[2] = O;
                        target_word[3] = R;
                        target_word[4] = P;
                        target_word[5] = I;
                        target_word[6] = O;
                        target_word[7] = N;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd40 : begin //SEA_TURTLE
                        word_length = 4'b1010;
                        target_word[0] = S;
                        target_word[1] = E;
                        target_word[2] = A;
                        target_word[3] = space;
                        target_word[4] = T;
                        target_word[5] = U;
                        target_word[6] = R;
                        target_word[7] = T;
                        target_word[8] = L;
                        target_word[9] = E;
                    end
                    8'd41 : begin //SHARK
                        word_length = 4'b101;
                        target_word[0] = S;
                        target_word[1] = H;
                        target_word[2] = A;
                        target_word[3] = R;
                        target_word[4] = K;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd42 : begin //SHEEP
                        word_length = 4'b101;
                        target_word[0] = S;
                        target_word[1] = H;
                        target_word[2] = E;
                        target_word[3] = E;
                        target_word[4] = P;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd43 : begin //SNAIL
                        word_length = 4'b101;
                        target_word[0] = S;
                        target_word[1] = N;
                        target_word[2] = A;
                        target_word[3] = I;
                        target_word[4] = L;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd44 : begin //SNAKE
                        word_length = 4'b101;
                        target_word[0] = S;
                        target_word[1] = N;
                        target_word[2] = A;
                        target_word[3] = K;
                        target_word[4] = E;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd45 : begin //SPIDER
                        word_length = 4'b110;
                        target_word[0] = S;
                        target_word[1] = P;
                        target_word[2] = I;
                        target_word[3] = D;
                        target_word[4] = E;
                        target_word[5] = R;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd46 : begin //SQUIRREL
                        word_length = 4'b1000;
                        target_word[0] = S;
                        target_word[1] = Q;
                        target_word[2] = U;
                        target_word[3] = I;
                        target_word[4] = R;
                        target_word[5] = R;
                        target_word[6] = E;
                        target_word[7] = L;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd47 : begin //SWAN
                        word_length = 4'b100;
                        target_word[0] = S;
                        target_word[1] = W;
                        target_word[2] = A;
                        target_word[3] = N;
                        target_word[4] = 0;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd48 : begin //TIGER
                        word_length = 4'b101;
                        target_word[0] = T;
                        target_word[1] = I;
                        target_word[2] = G;
                        target_word[3] = E;
                        target_word[4] = R;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd49 : begin //WHALE
                        word_length = 4'b101;
                        target_word[0] = W;
                        target_word[1] = H;
                        target_word[2] = A;
                        target_word[3] = L;
                        target_word[4] = E;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end
                    8'd50 : begin //ZEBRA
                        word_length = 4'b101;
                        target_word[0] = Z;
                        target_word[1] = E;
                        target_word[2] = B;
                        target_word[3] = R;
                        target_word[4] = A;
                        target_word[5] = 0;
                        target_word[6] = 0;
                        target_word[7] = 0;
                        target_word[8] = 0;
                        target_word[9] = 0;
                    end

        endcase
    end

    
    reg CLK50MHZ = 0;
    always @(posedge(clk))begin
            CLK50MHZ=~CLK50MHZ;
    end
    
    wire scan_done;
    wire [7:0] scan_code;
    wire reset;

    PS2Receiver test_1(CLK50MHZ,PS2Clk,PS2Data,keycode,oflag);
    
    reg flag = 0;
    reg [3:0] count = 0;
    

    reg new_data = 0;
    wire second_en;
    assign second_en = (correct_word != 2'd1); 
    always @(posedge clk) begin
        ow_0 <= words[0];
        ow_1 <= words[1];
        ow_2 <= words[2];
        ow_3 <= words[3];
        ow_4 <= words[4];
        ow_5 <= words[5];
        ow_6 <= words[6];
        ow_7 <= words[7];
        ow_8 <= words[8];
        ow_9 <= words[9];
        tw_0 <= target_word[0];
        tw_1 <= target_word[1];
        tw_2 <= target_word[2];
        tw_3 <= target_word[3];
        tw_4 <= target_word[4];
        tw_5 <= target_word[5];
        tw_6 <= target_word[6];
        tw_7 <= target_word[7];
        tw_8 <= target_word[8];
        tw_9 <= target_word[9];
        if(guess_init) begin
            if (btnR) begin
                correct_word = 2'd2;
                colour = WHITE;
                for(i=0; i <= 9;  i=i+1) begin
                    words[i] = 8'h0;
                    //led[i] = 1'b0;
                end
            end
            if(oflag) begin
                new_data = 1;
            end
            else if(~oflag && new_data) begin
                new_data = 0;
                if(keycode[15:8] == 8'hF0 && game_time > 6'd0 &&
                (correct_word == 2'd0 || correct_word == 2'd2)) begin // RELEASE FLAG
                    colour = WHITE;
                    if(keycode[7:0] == 8'h5A) begin //ENTER
                        flag = 1;
                        if(words[0] == target_word[0] 
                        && words[1] == target_word[1] 
                        && words[2] == target_word[2]
                        && words[3] == target_word[3]
                        && words[4] == target_word[4]
                        && words[5] == target_word[5]
                        && words[6] == target_word[6]
                        && words[7] == target_word[7]
                        && words[8] == target_word[8]
                        && words[9] == target_word[9]
                        ) begin
                            //led[14] = 1'b1;
                            correct_word = 2'd1;
                            colour = GREEN;
                        end
                        else begin
                            //led[14] = 1'b0;
                            correct_word = 2'd0;
                            colour = RED;
                        end  
                        count = 0;
                    end
                    
                    else if(keycode[7:0] == 8'h66) begin //BACKSPACE
                        correct_word = 2'd2;
                        colour = WHITE;
                        for(i=0; i <= 9;  i=i+1) begin
                            words[i] = 8'h0;
                            //led[i] = 1'b0;
                        end
                        flag = 0;
                        //led[14] = 0;
                        count = 0;
                    end

                    else begin
                        if(count == 4'b0) begin
                            //led[14] = 0;
                            for(i=0; i <= 10;  i=i+1) begin
                                words[i] = 8'h0;
                                //led[i] = 1'b0;
                            end
                        end
                        flag = 0;
                            
                        case(count)
                            4'b00 : begin
                                words[0] = keycode[7:0];
                                //led[10:0] = 11'b1;
                            end
                            4'b01 : begin
                                words[1] = keycode[7:0]; 
                                //led[10:0] = 11'b000011;
                            end
                            4'b10 : begin
                                words[2] = keycode[7:0]; 
                                //led[10:0] = 11'b000111;
                            end
                            4'b11 : begin
                                words[3] = keycode[7:0]; 
                                //led[10:0] = 11'b001111;
                            end
                            4'b100 : begin
                                words[4] = keycode[7:0]; 
                                //led[10:0] = 11'b011111;
                            end
                            4'b101 : begin
                                words[5] = keycode[7:0]; 
                                //led[10:0] = 11'b111111;
                            end
                            4'b110 : begin
                                words[6] = keycode[7:0]; 
                                //led[10:0] = 11'b1111111;
                            end
                            4'b111 : begin
                                words[7] = keycode[7:0]; 
                                //led[10:0] = 11'b11111111;
                            end
                            4'b1000 : begin
                                words[8] = keycode[7:0]; 
                                //led[10:0] = 11'b111111111;
                            end
                            4'b1001 : begin
                                words[9] = keycode[7:0]; 
                                //led[10:0] = 11'b1111111111;
                            end
                        endcase
                        count = count + 1;
                    end
                    //led[15] = flag;      
                end
            end
        end
        else begin
            //led = 16'b0000000000000000;
            for(i=0; i <= 9; i=i+1) begin
                words[i] = 8'h0;
//                target_word[i] = 8'h0;
            end
        end     
    end
endmodule