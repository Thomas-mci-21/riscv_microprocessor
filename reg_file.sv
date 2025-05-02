`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/09 09:49:24
// Design Name: 
// Module Name: reg_file
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

module reg_file #(
    parameter ADDR_WIDTH = 5,
    parameter DATAWIDTH = 32
)(
    input logic clk,                 // 时钟信号
    input logic rst,                 // 复位信号
    input logic wr_reg_en,           // 写使能
    input logic [ADDR_WIDTH-1:0] wr_reg_addr,   // 写寄存器地址
    input logic [DATAWIDTH-1:0] wr_wdata,      // 写数据
    input logic [ADDR_WIDTH-1:0] rs_reg1_addr,  // 读取寄存器1地址
    input logic [ADDR_WIDTH-1:0] rs_reg2_addr,  // 读取寄存器2地址
    output logic [DATAWIDTH-1:0] rs_reg1_rdata, // 读取寄存器1数据
    output logic [DATAWIDTH-1:0] rs_reg2_rdata  // 读取寄存器2数据
);

    // 寄存器堆定义，32个32位寄存器
    logic [DATAWIDTH-1:0] reg_bank [31:0];

    // 时钟或复位上升沿触发的过程
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // 复位时清空所有寄存器
            for (int i = 0; i < 32; i++) begin
                reg_bank[i] <= 32'b0; // 非阻塞赋值
            end
        end else if (wr_reg_en) begin
            // 写使能时，将数据写入指定的寄存器
            reg_bank[wr_reg_addr] <= wr_wdata; // 非阻塞赋值
        end
    end

    // 读取寄存器数据
    assign rs_reg1_rdata = reg_bank[rs_reg1_addr];
    assign rs_reg2_rdata = reg_bank[rs_reg2_addr];

endmodule
