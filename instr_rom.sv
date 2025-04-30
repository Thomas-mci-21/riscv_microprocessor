`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/13 10:15:31
// Design Name: 
// Module Name: instr_rom
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


module instr_rom #(
    parameter   DATAWIDTH   =   32  ,
    parameter   RAMWIDTH    =   8   ,
    parameter   RAMDEPTH    =   8  
)(
    input  logic                   ena      ,
    input  logic [DATAWIDTH - 1:0] daddr    ,
    output logic [DATAWIDTH - 1:0] dout     
);
    // 先用reg进行最简单的模拟，这段代码不会将reg综合为bram
    reg [RAMWIDTH - 1:0] rom [2**(RAMDEPTH) - 1:0];

    // 计算需要拼接的元素数量
    localparam NUM_ELEMENTS = DATAWIDTH / RAMWIDTH;

    // 根据使能信号和地址读取数据
    always @(*) begin
        integer i;
        if (ena) begin
            for (i = 0; i < NUM_ELEMENTS; i = i + 1) begin
                dout[(i + 1) * RAMWIDTH - 1 -: RAMWIDTH] = rom[daddr + i];
            end
        end else begin
            dout = {DATAWIDTH{1'b0}};
        end
    end

endmodule
