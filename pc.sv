`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/06 20:09:18
// Design Name: 
// Module Name: pc
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


module pc#(
    parameter   DATAWIDTH = 32
)(
    input  logic                   clk  ,
    input  logic                   rst  ,
    input  logic [DATAWIDTH - 1:0] npc  ,
    output logic [DATAWIDTH - 1:0] pc_out   
);
    always_ff @(posedge clk or posedge rst) begin  // 将 ck 改为 clk
        if(rst) begin
            pc_out <= 32'b0;
        end
        else begin
            pc_out <= npc;  // 将 pc 改为 npc
        end
    end
endmodule
