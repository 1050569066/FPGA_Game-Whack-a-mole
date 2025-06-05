`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/22 19:37:01
// Design Name: 
// Module Name: recounter10
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


module recounter10(clk,clr,EN,Q,cy,start);
	input clk,clr;
	input EN;               //ʹ���ź�
	input start;
	output cy;              //��������λ���
	output reg [3:0] Q= 4'b0;     // �����������
         always @(posedge clk or negedge clr)  //�첽����
              begin
                  if (~clr)       //������Ч
                    begin 
                     Q<=0;
                   end          //���������������������Ϊ0
                  else if(EN && start)  //ʹ����Ч
                    begin
                     if (Q==0)    //����+1������λ�Ѿ��������9
                      begin 
                        Q<=9;      //�����ת����С��0
                        end
                     else Q<=Q-1;       //�����δ�����������ֻ��1
                     end
              end
               //�Ƶ������9��ͬʱʹ����Ч�����CyΪ1
              assign cy=((EN==1)&&(Q==0))?1'b1:1'b0;
endmodule

