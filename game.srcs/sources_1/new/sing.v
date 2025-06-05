`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/30 12:51:11
// Design Name: 
// Module Name: choose
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

module choose(
    input wire clk,
    input wire rst_n,
    input wire B,            // ����ѡ��
    input wire DONE,         // ����ʱ���
    input wire beep_e,       // ��ʹ��
    output reg buz          // ���������
    
);

// �ڲ�����������Ƶ�ʺ�ʱ��
parameter TIME_NORMAL = 25'd25_000_000;  
parameter TIME_FAST   = TIME_NORMAL / 2; 
parameter TIME_SLOW   = TIME_NORMAL * 2; 

reg [26:0] TIME;             // ��̬�ٶȿ���
reg [7:0] cnt_num;           // ����������
reg [26:0] cnt_250;          // ��������ʱ��
reg [1:0] spd = 2'b11;
reg stp = 0;
wire beep_en;

// �ٶ�ѡ���߼�
always @(*) begin
    case (spd)
        2'b00: TIME = TIME_NORMAL;
        2'b01: TIME = TIME_NORMAL;
        2'b10: TIME = TIME_SLOW;
        2'b11: TIME = TIME_FAST;
        default: TIME = TIME_NORMAL;
    endcase
end

// ����ʹ���źţ�Z=0ʱ�����ţ�
assign beep_en = ~beep_e && DONE && ~stp;

// ��������ʱ�߼�
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_250 <= 0;
    end else if (beep_en) begin
        if (cnt_250 >= TIME - 1) begin
            cnt_250 <= 0;
        end else begin
            cnt_250 <= cnt_250 + 1;
        end
    end
end

// �����л��߼������׸�����
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_num <= 0;
        stp <= 0;
    end else if (beep_en) begin
        if (cnt_250 == TIME - 1) begin
            if (cnt_num == (B ? 6'd50 : 8'd79)) begin 
                cnt_num <= 0;
                stp <= 1;
            end else begin
                cnt_num <= cnt_num + 1;
            end
        end
    end
end

// PWM�����߼���ռ�ձ�50%��
reg [17:0] frq;              // ����Ƶ��
parameter   CYCLE = 26'd50_000_000  ;

parameter   DOL   = CYCLE/262       ,
            REL   = CYCLE/294       ,
            MIL   = CYCLE/330       ,
            FAL   = CYCLE/349       ,
            SOL   = CYCLE/392       ,
            LAL   = CYCLE/440       ,
            XIL   = CYCLE/494       ,
            DOM   = CYCLE/523       ,
            REM   = CYCLE/587       ,
            MIM   = CYCLE/659       ,
            FAM   = CYCLE/698       ,
            SOM   = CYCLE/784       ,
            LAM   = CYCLE/880       ,
            XIM   = CYCLE/988       ,
            DOH   = CYCLE/1047      ,
            REH   = CYCLE/1175      ,
            MIH   = CYCLE/1319      ,
            FAH   = CYCLE/1397      ,
            SOH   = CYCLE/1568      ,
            LAH   = CYCLE/1760      ,
            XIH   = CYCLE/1967      ;



always @(*) begin
    if (B == 0) begin        // ����1������
        spd <= 2'b00;
        case (cnt_num)
            6'd0     :   frq = MIM;    // 1����������ʼ����
            6'd1     :   frq = MIM;    // 3��C���������
            6'd2     :   frq = FAM;    // 5���߰˶�ǿ�����ӸУ�
            6'd3     :   frq = SOM;    // 1���ظ��ṹ��
            6'd4     :   frq = SOM;    // 3
            6'd5     :   frq = FAM;    // 5
            6'd6     :   frq = MIM;    // 6���������̵棩
            6'd7     :   frq = REM;    // 5���������䣩
            6'd8     :   frq = DOM;  // 4������IV����������
            6'd9     :   frq = DOM;    // 1������ѭ����
            6'd10    :   frq = REM;    // ��ֹ���������϶��
            6'd11    :   frq = MIM;    // 1������ֹ�Ľ����ͣ�
            6'd12    :   frq = MIM;    // 3
            6'd13    :   frq = MIM;    // 5
            6'd14     :  frq = REM;    // 1����������ʼ����
            6'd15    :   frq = REM;    // 3��C���������
            6'd16    :   frq = DOM;    // 5���߰˶�ǿ�����ӸУ�
            6'd17    :   frq = DOH;    // 1���ظ��ṹ��
            6'd18    :   frq = REM;    // 3
            6'd19    :   frq = DOM;    // 5
            6'd20    :   frq = LAM;    // 6���������̵棩
            6'd21    :   frq = DOH;    // 5���������䣩
            6'd22    :   frq = REM;  // 4������IV����������
            6'd23    :   frq = DOM;    // 1������ѭ����
            6'd24    :   frq = DOH;    // ��ֹ���������϶��
            6'd25    :   frq = REM;    // 1������ֹ�Ľ����ͣ�
            6'd26    :   frq = DOM;    // 3
            6'd27    :   frq = 0;    // 5
            6'd28    :   frq = DOH;    // 1���߰˶ȱ��ࣩ
            6'd29    :   frq = XIM;    // 3����Ƶ��׺��
            6'd30    :   frq = SOM;    // 5
            6'd31    :   frq = DOH;    // 6���������ɣ�
            6'd32    :   frq = XIM;    // 5
            6'd33    :   frq = MIM;    // 4
            6'd34    :   frq = LAL;    // 1
            6'd35    :   frq = DOH;    // ��ֹ��
            6'd36    :   frq = XIM;    // 2�������ͱ仯��
            6'd37    :   frq = SOM;    // 4
            6'd38    :   frq = DOH;    // 5
            6'd39    :   frq = XIM;    // 1
            6'd40    :   frq = DOM;    // 3
            6'd41    :   frq = 0;    // 5
            6'd42    :   frq = DOH;    // 1
            6'd43    :   frq = XIM;    // 3
            6'd44    :   frq = DOM;    // 5
            6'd45    :   frq = DOH;    // 6
            6'd46    :   frq = XIM;    // 5
            6'd47    :   frq = MIM;    // 4
            6'd48    :   frq = REH;    // 1
            6'd49    :   frq = 0;    // ��ֹ������β׼����
            6'd50    :   frq = 0;    // 1����Ƶ��β��
            default  :   frq = 0;

        endcase
    end else begin           // ����2������
        spd <= 2'b11;
        case (cnt_num)
            8'd0      : frq = MIM;    // 5��
            8'd1      : frq = MIH;    // 3
            8'd2      : frq = MIH;    // 2
            8'd3      : frq = REH;    // 1
            8'd4      : frq = MIH;    // 5��
            8'd5      : frq = LAH;    // 3
            8'd6      : frq = SOH;    // 2
            8'd7      : frq = SOH;    // 1
            8'd8      : frq = MIH;    // 6��
            8'd9      : frq = MIH;    // 5
            8'd10     : frq = SOH;    // 4��
            8'd11     : frq = SOH;    // 3
            8'd12     : frq = 0;    // 2
            8'd13     : frq = LAH;    // 1
            8'd14     : frq = DOH;    // ��ֹ
            8'd15     : frq = LAM;    // 5��
            8'd16     : frq = XIM;    // 3
            8'd17     : frq = DOH;    // 2
            8'd18     : frq = FAH;    // 1
            8'd19     : frq = MIH;    // 5��
            8'd20     : frq = REH;    // 3
            8'd21     : frq = DOH;    // 2
            8'd22     : frq = 0;    // 1
            8'd23     : frq = DOH;    // 6��
            8'd24     : frq = LAM;    // 5
            8'd25     : frq = XIM;    // 4��
            8'd26     : frq = DOH;    // 3
            8'd27     : frq = DOH;    // 2
            8'd28     : frq = DOH;    // 1
            8'd29     : frq = FAH;    // ��ֹ
            8'd30     : frq = MIH;    // 5��
            8'd31     : frq = MIH;    // 3
            8'd32     : frq = DOH;    // 3
            8'd33     : frq = REH;    // 2
            8'd34     : frq = 0;    // 1
            8'd35     : frq = MIH;    // 5��
            8'd36     : frq = LAM;    // 3
            8'd37     : frq = LAM;    // 2
            8'd38     : frq = XIM;    // 1
            8'd39     : frq = XIM;    // 6��
            8'd40     : frq = SOM;    // 5
            8'd41     : frq = LAM;    // 4��
            8'd42     : frq = LAM;    // 3
            8'd43     : frq = LAM;    // 2
            8'd44     : frq = LAM;    // 1
            8'd45     : frq = 0;    // ��ֹ
            8'd46     : frq = 0;    // 5��
            8'd47     : frq = 0;    // 3
            8'd48     : frq = XIM;    // 3
            8'd49     : frq = DOH;    // 2
            8'd50     : frq = XIM;    // 1
            8'd51     : frq = LAM;    // 5��
            
            8'd52     : frq = 0;    // 3
            8'd53     : frq = 0;    // 2
            8'd54     : frq = 0;    // 1
            8'd55     : frq = 0;    // 6��
            8'd56     : frq = 0;    // 5
            8'd57     : frq = 0;    // 4��
            8'd58     : frq = 0;    // 3
            8'd59     : frq = REM;    // 2
            8'd60     : frq = DOM;    // 1
            8'd61     : frq = XIL;    // ��ֹ
            8'd62     : frq = SOL;    // 5��
            8'd63     : frq = MIM;    // 3
            8'd64     : frq = SOH;    // 5��
            8'd65     : frq = LAH;    // 6��
            8'd66     : frq = SOH;    // 5��
            8'd67     : frq = FAH;    // 4��
            8'd68     : frq = MIH;    // 3��
            8'd69     : frq = REM;    // 2
            8'd70     : frq = DOM;    // 1
            8'd71     : frq = XIL;    // ��ֹ
            8'd72     : frq = SOH;    // 5��
            8'd73     : frq = LAH;    // 6��
            8'd74     : frq = SOH;    // 5��
            8'd75     : frq = FAH;    // 4��
            8'd76     : frq = MIH;    // 3��
            8'd77     : frq = REM;    // 2
            8'd78     : frq = DOM;    // 1
            8'd79     : frq = XIL;    // ��ֹ
            default   : frq = 0;

        endcase
    end
end

// ����PWM�ź�����������
reg [17:0] cnt_frq;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_frq <= 0;
        buz <= 0;
    end else if (beep_en) begin
        if (cnt_frq >= frq) begin
            cnt_frq <= 0;
            buz <= ~buz;    // 50%ռ�ձ�
        end else begin
            cnt_frq <= cnt_frq + 1;
        end
    end else begin
        buz <= 0;
    end
end

endmodule