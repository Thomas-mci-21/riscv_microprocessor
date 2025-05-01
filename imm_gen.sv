module imm_gen#(
    parameter   DATAWIDTH = 32  
)(
    input  logic [31:0]            instr,   // 输入指令
    output logic [DATAWIDTH - 1:0] imm       // 输出的立即数
);

    always_comb begin
        case (instr[6:0])  // 根据指令的opcode来决定立即数的格式
            7'b0000011: begin  // I-type 指令，例：lw, lb, 等
                imm = {{20{instr[31]}}, instr[31:20]};  // 符号扩展
            end
            7'b0100011: begin  // S-type 指令，例：sw, sb, 等
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // 符号扩展
            end
            7'b1100011: begin  // B-type 指令，例：beq, bne, 等
                imm = {{19{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // 符号扩展
            end
            7'b0010011: begin  // I-type 指令，例：addi, slti, 等
                imm = {{20{instr[31]}}, instr[31:20]};  // 符号扩展
            end
            7'b0110111: begin  // U-type 指令，例：LUI
                imm = {instr[31:12], 12'b0};  // 高20位来自指令，低12位为0
            end
            7'b0010111: begin  // U-type 指令，例：AUIPC
                imm = {instr[31:12], 12'b0};  // 高20位来自指令，低12位为0
            end
            7'b1101111: begin  // J-type 指令，例：JAL
                imm = {{11{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; // 符号扩展
            end
            default: begin
                imm = 32'b0;  // 如果不需要立即数，返回任意值（此处为0）
            end
        endcase
    end

endmodule
