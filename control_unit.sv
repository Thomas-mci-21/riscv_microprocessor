`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: control unit
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

module control(
    input  logic [6:0]  opcode,   
    input  logic        alu_ctrl_isTrue_i ,

    output logic        PCsrc,     // 分支指令有效
    output logic        MemToReg,   
    output logic        MemWrite,  
    output logic [1:0]  ALUOP,      
    output logic        ALUSrc,     //TODO: 链接模块时添加ALUsrc mux 用于选择立即数还是寄存器
    output logic        RegWrite    
);

    logic Branch;

always_comb begin
    case(opcode)
        // R-type指令（ADD/SUB/AND/OR/XOR/SLT等） <10条>
        7'b0110011: begin
            Branch    = 1'b0;  //brch
            MemToReg  = 1'b0;  //mem
            MemWrite  = 1'b0;
            ALUOP     = 2'b10; //alu
            ALUSrc    = 1'b0;  //使用regB
            RegWrite  = 1'b1;  //reg
        end
        
        // I-type算术指令（ADDI/ANDI/ORI/XORI/SLTI/../srai等） <9条>
        //TODO:存在两种immgen逻辑：imm/shamt，immgen模块需要分开处理
        7'b0010011: begin

            Branch    = 1'b0;  //brch
            MemToReg  = 1'b0;  //mem
            MemWrite  = 1'b0;
            ALUOP     = 2'b10; //操作类型由funct3决定
            ALUSrc    = 1'b1;  //使用立即数
            RegWrite  = 1'b1;  //reg
        end
        
        // Load指令（LW/lh/lb/..）  <5条>
        7'b0000011: begin
            Branch    = 1'b0;  //brch
            MemToReg  = 1'b1;  //mem
            MemWrite  = 1'b0;
            ALUOP     = 2'b00; //操作类型由funct3决定
            ALUSrc    = 1'b1;  //基地址+偏移量
            RegWrite  = 1'b1;  //reg
        end
        
        // Store指令（SW/sb/sh） <3条>
        7'b0100011: begin
            Branch    = 1'b0;  //brch
            MemToReg  = 1'b0;  //实际是X
            MemWrite  = 1'b1;  //写内存
            ALUOP     = 2'b00; 
            ALUSrc    = 1'b1;  //使用imm
            RegWrite  = 1'b0;  //reg
        end
        
        // Branch指令（BEQ/BNE/BLT/BGE/bltu/bgeu） <6条>
        7'b1100011: begin

            Branch    = 1'b1;  //brch taken
            MemToReg  = 1'b0;  //实际是X
            MemWrite  = 1'b0;  
            ALUOP     = 2'b01; //比较
            ALUSrc    = 1'b0;  
            RegWrite  = 1'b0;  

        end
        
        //TODO: 扩展指令集： lui/auipc/jal/jalr等
        /*
        7'b0110111: begin
            RegWrite = 1'b1;    // 写寄存器
            ALUSrc   = 1'b1;    // 直接使用立即数
            ALUOP    = 2'b11;   // 高位立即数直通
        end
        
        // AUIPC指令
        7'b0010111: begin
            RegWrite = 1'b1;    // 写寄存器
            ALUSrc   = 1'b1;    // 使用PC相对地址
            ALUOP    = 2'b00;   // ALU执行加法（PC + imm）
        end
        
        // JAL指令
        7'b1101111: begin
            RegWrite = 1'b1;    // 写返回地址到rd
            ALUOP    = 2'b00;   // PC计算使用专用路径
        end
        
        // JALR指令
        7'b1100111: begin
            RegWrite = 1'b1;    // 写返回地址到rd
            ALUSrc   = 1'b1;    // 使用立即数偏移
            ALUOP    = 2'b00;   // ALU执行加法（rs1 + imm）
        end
        */
        
        default: begin
            Branch    = 1'b0;  //brch
            MemToReg  = 1'b0;  //mem
            MemWrite  = 1'b0;
            ALUOP     = 2'b00; //alu
            ALUSrc    = 1'b0;
            RegWrite  = 1'b0;  //reg
        end

    endcase
end

    assign PCsrc = Branch & alu_ctrl_isTrue_i; // 分支指令有效且ALU结果为真，PCsrc有效

endmodule