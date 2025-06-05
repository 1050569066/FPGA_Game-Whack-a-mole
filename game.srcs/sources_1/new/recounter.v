`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/22 19:35:52
// Design Name: 
// Module Name: recounter
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

module recounter(
    input clk,
    input CLR_L,
    input start_stop,
    input [3:0] success,
    input [4:0] win,
    output [7:0] seg,
    output [5:0] dig,
    output wire [3:0] Q_1,
    output wire EN
    );
     //��Ƶ����
	wire clk_s;
//���տμ��϶���ģ������ͼ��������д����Ƶ��·���������
	 clk_div2 u1(.clk_in(clk),.clk_out(clk_s));
        wire[3:0] Q_0;// �����������
        wire cy_0,cy_1;  //��λ�ź�

    recounter9 uut1(.clk(clk_s),.clr(CLR_L),.EN(EN&cy_0),.Q(Q_1),.cy(cy_1),.start(start_stop));
    recounter10 uut2(.clk(clk_s),.clr(CLR_L),.EN(EN),.Q(Q_0),.cy(cy_0),.start(start_stop));
        assign EN=((Q_0==0)&&(Q_1==0))?1'b0:1'b1;
    //����3λ�������ʾģ��
          wire[3:0] disp_data_right0,disp_data_right1,disp_data_right2;
          assign disp_data_right0=Q_0;
          assign disp_data_right1=Q_1;
          dynamicled2 u5 (
          .disp_data_right0(disp_data_right0),
          .disp_data_right1(disp_data_right1),
          .clk(clk),
          .seg(seg),
          .dig(dig),
          .disp_data_right4(success),
          .disp_data_right5(win)
          );        
    
endmodule

