`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: 
// Project Name: alu_controller
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


`include "defines.svh"

module alu_control(
    input  logic [1:0]  ALUOP,
    input  logic [2:0]  funct3,
    input  logic        funct7,
    output logic [3:0]  ALUControl
);

always_comb begin
    case(ALUOP)
        `ALUOP_ADD: ALUControl = `ALU_ADD;      
        `ALUOP_SUB: ALUControl = `ALU_SUB;      
        `ALUOP_FUNC: begin
            case(funct3)
                3'b000: ALUControl = funct7 ? `ALU_SUB : `ALU_ADD; 
                3'b111: ALUControl = `ALU_AND; 
                3'b110: ALUControl = `ALU_OR;  
                3'b100: ALUControl = `ALU_XOR; 
                3'b010: ALUControl = `ALU_SLT; // 有符号比较
                default: ALUControl = `ALU_ADD;
            endcase
        end
        `ALUOP_PASS: ALUControl = `ALU_PASS;    // 直通（LUI）
        default: ALUControl = `ALU_ADD;        // 默认加法
    endcase
end

endmodule