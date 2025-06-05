`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/29 19:37:01
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input CLR_L,
    input start_stop,
    input [3:0] col_in,  // 列输入（上拉）
    input [1:0] speed,
    input random_sw,
    input beep_e,
    input interesting,
    output buz,
    output [3:0] row_out,// 行输出（低有效）
    output [7:0] seg,
    output [5:0] dig,
    output [15:0] led
    );
    
wire [3:0] Q_1;
wire [3:0] success;
wire [15:0] key;
wire stop;
wire [4:0] win;
wire B;


recounter recounter(
    .clk(clk),
    .CLR_L(CLR_L),
    .start_stop(start_stop),
    .seg(seg),
    .dig(dig),
    .Q_1(Q_1),
    .success(success),
    .EN(stop),
    .win(win)
    );



matrix_scan button(
    .clk(clk),           
    .col_in(col_in),  
    .row_out(row_out),
    .key(key)   
);



random_led random(
    .clk(clk),
    .Q_1(Q_1),
    .CLR_R(CLR_L),
    .led(led),
    .key(key),
    .success(success),
    .start(start_stop),
    .stop(~stop),
    .speed(speed),
    .random_sw(random_sw),
    .interesting(interesting)
    );



check check(
    .clk(clk),
    .success(success),
    .stop(~stop),
    .CLR_R(CLR_L),
    .win(win),
    .B(B)
    );

choose sing(
    .clk(clk),
    .rst_n(CLR_L),
    .B(~B),            // 歌曲选择
    .DONE(~stop),         // 倒计时完成
    .beep_e(beep_e),       // 总使能
    .buz(buz)          // 蜂鸣器输出
    
);

    
endmodule
