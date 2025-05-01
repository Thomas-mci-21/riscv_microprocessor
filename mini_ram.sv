`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 11:34:19 AM
// Design Name: 
// Module Name: mini_ram
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


module mini_ram #(
    parameter   DATAWIDTH   =   8  ,
    parameter   RAMDEPTH    =   8  
)(
    input  logic                   clk         ,
    input  logic                   wen         ,          
	input  logic                   ena         ,
    input  logic [RAMDEPTH  - 1:0] ram_addr_i  ,
    input  logic [DATAWIDTH - 1:0] ram_data_i  ,
    output logic [DATAWIDTH - 1:0] ram_data_o
);

// 定义 RAM：2^RAMDEPTH 个 DATAWIDTH 位单元
reg [DATAWIDTH-1:0] ram [0:(1<<RAMDEPTH)-1];

// 写操作：同步写
always_ff @(posedge clk) begin
    if (ena && wen) begin
        ram[ram_addr_i] <= ram_data_i;
    end
end

// 读操作：异步读
always_comb begin
    ram_data_o = ram[ram_addr_i];
end

endmodule
