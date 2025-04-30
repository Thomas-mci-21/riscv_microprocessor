`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/05 13:26:52
// Design Name: 
// Module Name: alu
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


module alu#(
    parameter   DATAWIDTH = 32	
)(
    input  logic [DATAWIDTH - 1:0]  A           ,
    input  logic [DATAWIDTH - 1:0]  B           ,
    input  logic [1:0]              ALUControl  ,
    output logic [DATAWIDTH - 1:0]  Result      ,
    output logic                    N           ,
    output logic                    Z           ,
    output logic                    V           ,
    output logic                    C           
);

// 计算Result
always_comb begin
    case (ALUControl)
        2'b00:  {C, Result} = A + B;
        2'b01: Result = A - B;
        2'b10: Result = A & B;
        2'b11: Result = A | B;
        default: Result = 0;
    endcase
end

// 计算负标志N和零标志Z
always_comb begin
    N = Result[DATAWIDTH - 1];
    Z = (Result == 0);
end

// 计算进位标志C（减法时特殊处理）
always_comb begin
    case (ALUControl)
        2'b00: ; // 加法时进位已经在上面计算
        2'b01: C = (A >= B);
        2'b10: C = 1'b0;
        2'b11: C = 1'b0;
        default: C = 1'b0;
    endcase
end

// 计算溢出标志V
always_comb begin
    case (ALUControl)
        2'b00: V = (A[DATAWIDTH - 1] == B[DATAWIDTH - 1]) && (A[DATAWIDTH - 1] != Result[DATAWIDTH - 1]);
        2'b01: V = (A[DATAWIDTH - 1] != B[DATAWIDTH - 1]) && (A[DATAWIDTH - 1] != Result[DATAWIDTH - 1]);
        2'b10: V = 1'b0;
        2'b11: V = 1'b0;
        default: V = 1'b0;
    endcase
end




endmodule
