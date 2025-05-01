`ifndef DEFINES_SV
`define DEFINES_SV

// ALU 操作码宏定义
`define ALU_ADD     4'b0000  // 加法
`define ALU_SUB     4'b0001  // 减法
`define ALU_AND     4'b0010  // 按位与
`define ALU_OR      4'b0011  // 按位或
`define ALU_XOR     4'b0100  // 按位异或
`define ALU_SLT     4'b0101  // 有符号比较（小于置1）
`define ALU_PASS    4'b0110  // 直通（用于LUI）

// ALUOP 宏定义
`define ALUOP_ADD   2'b00    // 加法操作
`define ALUOP_SUB   2'b01    // 减法操作
`define ALUOP_FUNC  2'b10    // 由funct3/funct7决定操作
`define ALUOP_PASS  2'b11    // 直通操作（用于LUI）

`endif // DEFINES_SV