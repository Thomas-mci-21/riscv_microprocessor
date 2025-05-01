`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 11:34:19 AM
// Design Name: 
// Module Name: mini_ram_bitext
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


module mini_ram_bitext #(
    parameter   DATAWIDTH   =   32  ,
    parameter   RAMDEPTH    =   10  
)(
    input  logic                   clk         ,
    input  logic                   wen         ,          
	input  logic                   ena         ,
    input  logic [RAMDEPTH  - 1:0] ram_addr_i  ,
    input  logic [DATAWIDTH - 1:0] ram_data_i  ,
    output logic [DATAWIDTH - 1:0] ram_data_o
);

// 分别接 4 片 mini_ram_wordext，每片负责 8bit
logic [7:0] ram_data_o_0, ram_data_o_1, ram_data_o_2, ram_data_o_3;

mini_ram_wordext #(.DATAWIDTH(8), .RAMDEPTH(RAMDEPTH)) ram0 (
    .clk(clk),
    .wen(wen),
    .ena(ena),
    .ram_addr_i(ram_addr_i),
    .ram_data_i(ram_data_i[7:0]),
    .ram_data_o(ram_data_o_0)
);

mini_ram_wordext #(.DATAWIDTH(8), .RAMDEPTH(RAMDEPTH)) ram1 (
    .clk(clk),
    .wen(wen),
    .ena(ena),
    .ram_addr_i(ram_addr_i),
    .ram_data_i(ram_data_i[15:8]),
    .ram_data_o(ram_data_o_1)
);

mini_ram_wordext #(.DATAWIDTH(8), .RAMDEPTH(RAMDEPTH)) ram2 (
    .clk(clk),
    .wen(wen),
    .ena(ena),
    .ram_addr_i(ram_addr_i),
    .ram_data_i(ram_data_i[23:16]),
    .ram_data_o(ram_data_o_2)
);

mini_ram_wordext #(.DATAWIDTH(8), .RAMDEPTH(RAMDEPTH)) ram3 (
    .clk(clk),
    .wen(wen),
    .ena(ena),
    .ram_addr_i(ram_addr_i),
    .ram_data_i(ram_data_i[31:24]),
    .ram_data_o(ram_data_o_3)
);

// 组合逻辑拼接输出
always_comb begin
    ram_data_o = {ram_data_o_3, ram_data_o_2, ram_data_o_1, ram_data_o_0};
end

endmodule
