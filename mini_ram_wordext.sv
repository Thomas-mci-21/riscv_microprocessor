`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 11:34:19 AM
// Design Name: 
// Module Name: mini_ram_wortext
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


module mini_ram_wordext #(
    parameter   DATAWIDTH   =   8  ,
    parameter   RAMDEPTH    =   10  
)(
    input  logic                   clk         ,
    input  logic                   wen         ,          
	input  logic                   ena         ,
    input  logic [RAMDEPTH  - 1:0] ram_addr_i  ,
    input  logic [DATAWIDTH - 1:0] ram_data_i  ,
    output logic [DATAWIDTH - 1:0] ram_data_o
);

 // 高两位地址决定访问哪一片 RAM
wire [1:0] bank_sel = ram_addr_i[9:8];
wire [7:0] local_addr = ram_addr_i[7:0];

logic [DATAWIDTH-1:0] ram_data_o_0, ram_data_o_1, ram_data_o_2, ram_data_o_3;

// 实例化 4 片 mini_ram
mini_ram #(.DATAWIDTH(DATAWIDTH), .RAMDEPTH(8)) ram0 (
    .clk(clk),
    .wen(wen && (bank_sel == 2'd0)),
    .ena(ena && (bank_sel == 2'd0)),
    .ram_addr_i(local_addr),
    .ram_data_i(ram_data_i),
    .ram_data_o(ram_data_o_0)
);

mini_ram #(.DATAWIDTH(DATAWIDTH), .RAMDEPTH(8)) ram1 (
    .clk(clk),
    .wen(wen && (bank_sel == 2'd1)),
    .ena(ena && (bank_sel == 2'd1)),
    .ram_addr_i(local_addr),
    .ram_data_i(ram_data_i),
    .ram_data_o(ram_data_o_1)
);

mini_ram #(.DATAWIDTH(DATAWIDTH), .RAMDEPTH(8)) ram2 (
    .clk(clk),
    .wen(wen && (bank_sel == 2'd2)),
    .ena(ena && (bank_sel == 2'd2)),
    .ram_addr_i(local_addr),
    .ram_data_i(ram_data_i),
    .ram_data_o(ram_data_o_2)
);

mini_ram #(.DATAWIDTH(DATAWIDTH), .RAMDEPTH(8)) ram3 (
    .clk(clk),
    .wen(wen && (bank_sel == 2'd3)),
    .ena(ena && (bank_sel == 2'd3)),
    .ram_addr_i(local_addr),
    .ram_data_i(ram_data_i),
    .ram_data_o(ram_data_o_3)
);

// 根据 bank_sel 输出对应的读数据
always_comb begin
    case (bank_sel)
        2'd0: ram_data_o = ram_data_o_0;
        2'd1: ram_data_o = ram_data_o_1;
        2'd2: ram_data_o = ram_data_o_2;
        2'd3: ram_data_o = ram_data_o_3;
        default: ram_data_o = '0;
    endcase
end

endmodule
