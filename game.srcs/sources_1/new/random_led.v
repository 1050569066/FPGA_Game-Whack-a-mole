`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/29 19:46:29
// Design Name: 
// Module Name: random_led
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


module random_led(
    input clk,
    input [3:0] Q_1,
    input CLR_R,
    input start,
    input [15:0] key,
    input stop,
    input [1:0] speed,
    input random_sw,
    input interesting,
    output reg [3:0] success,
    output reg [15:0] led
    );

reg [3:0] random_num;
reg [3:0] random_led2;
reg [4:0] lfsr = 5'b00001;
reg [4:0] lfsr1 = 5'b00110;
reg [31:0] cnt = 25'd24999999;
reg [15:0] check_led;
wire feedback = lfsr[4] ^ lfsr[2];
wire feedback1 = lfsr1[4] ^ lfsr1[2];
wire clk_out;
wire [31:0] random_num2;
wire [31:0] final_cnt;


reg [31:0] stable_random = 24999999;
always @(posedge clk_out) begin
    stable_random <= random_num2;
end





random_generator rand_gen (
    .clk(clk),
    .rst_n(CLR_R),
    .random_num(random_num2)
);



always @(posedge clk)begin
    case(speed)
        2'b00:cnt <= 25'd24999999;
        2'b01:cnt <= 25'd24999999;
        2'b10:cnt <= 26'd49999999;
        2'b11:cnt <= 25'd12499999;
        default:cnt <= 25'd24999999;
    endcase
end

assign final_cnt = random_sw? stable_random:cnt;

clk_div clk_div(
    .clk_in(clk),
    .clk_out(clk_out),
    .cnt(final_cnt)
);



always@ (posedge clk or negedge CLR_R)begin
    if(~CLR_R)begin
        lfsr <= 5'b1;
        lfsr1 <= 5'b00110;
    end else begin
        lfsr <= {lfsr[3:0] , feedback};
        lfsr1 <= {lfsr1[3:0] , feedback1};
    end
    
    
end

reg flag = 0;
reg toggle_clr = 0;
reg sync_toggle0, sync_toggle1;
wire clear_flag;


// ԭ��һ��always�飺��Ϊ��clk_out������ͬ���ź�
always @(posedge clk_out) begin
    random_num <= lfsr[3:0];  // �������������
    random_led2 <= lfsr1[3:0];
    toggle_clr <= ~toggle_clr; // ���ɿ�ʱ����ͬ���ź�
end

// ͬ��toggle_clr��clk��
always @(posedge clk or negedge CLR_R) begin
    if (~CLR_R) begin
        sync_toggle0 <= 0;
        sync_toggle1 <= 0;
    end else begin
        sync_toggle0 <= toggle_clr;
        sync_toggle1 <= sync_toggle0;
    end
end

// �����������������壨����1��clk���ڣ�
assign clear_flag = (sync_toggle0 ^ sync_toggle1);

// �ع���Ŀ����߼�
always @(posedge clk or negedge CLR_R) begin
    if (~CLR_R) begin
        led <= 16'b1111111111111111;
        check_led <= 16'b1111111111111111;
        success <= 0;
        flag <= 0;          // ��λflag
    end else begin
        // �ȴ����ʱ��������
        if (clear_flag) 
            flag <= 0;
        
        if (start && ~stop) begin
            led <= 0;
            check_led <= 0;
            led[random_num] <= 1; // ʹ�����������
            led[random_led2] <= interesting?1:0;
            check_led[random_num] <= 1;
            // ƥ���⣨����flagδ��λʱ��
            if (~flag && (key == check_led)) begin
                success <= success + 1;
                flag <= 1;  // �����ƥ��
            end
        end
    end
end
 
   
endmodule

module random_generator(
    input clk,          // ʱ������
    input rst_n,        // �첽�͵�ƽ��λ
    output reg [31:0] random_num  // ���ɵ������ (12499999-99999999)
);

// 32λLFSR�Ĵ���
reg [31:0] lfsr;

// LFSR��������ʽ��x^32 + x^22 + x^2 + x^1 + 1
wire feedback = lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0];

// ��Χ����
localparam MIN_VAL = 6249999;
localparam MAX_VAL = 49999999;
localparam RANGE = MAX_VAL - MIN_VAL + 1;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // ��λʱ��ʼ��LFSRΪ����ֵ
        lfsr <= 32'hABCD1234;
    end else begin
        // LFSR��λ����
        lfsr <= {lfsr[30:0], feedback};
    end
end

// ��LFSRֵӳ�䵽ָ����Χ
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        random_num <= MIN_VAL;  // ��λʱ�����Сֵ
    end else begin
        // ӳ�乫ʽ��MIN_VAL + (lfsr % RANGE)
        // ʹ��λ�������ⰺ���ȡģ����
        random_num <= MIN_VAL + (lfsr % RANGE);
    end
end

endmodule
