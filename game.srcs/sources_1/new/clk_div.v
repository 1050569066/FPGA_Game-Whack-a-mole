`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/22 19:07:04
// Design Name: 
// Module Name: clk_div
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


module clk_div(clk_in,clk_out,cnt);
	input clk_in;
	input [31:0] cnt;
	output reg clk_out=0;//��reg����always����Ҫ�ı���ֵ
 	reg[31:0] clk_div_cnt=0;
//��ƵΪ5Hz���ź�
        always @ (posedge clk_in)
        begin
            if (clk_div_cnt>=cnt-1)//10M��Ƶ
            begin
                clk_out=~clk_out;
                clk_div_cnt=0;
            end
            else 
                clk_div_cnt=clk_div_cnt+1;
       end
 endmodule
