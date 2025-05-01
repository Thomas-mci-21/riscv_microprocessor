module reg_file #(
    parameter   ADDR_WIDTH = 5  ,
    parameter   DATAWIDTH  = 32
)(
    input  logic                    clk            ,
    input  logic                    rst            ,
    // Write rd                   
    input  logic                    wr_reg_en      ,
    input  logic [ADDR_WIDTH - 1:0] wr_reg_addr    ,
    input  logic [DATAWIDTH - 1:0]  wr_wdata       ,
    // Read  rs1 rs2
    input  logic [ADDR_WIDTH - 1:0] rs_reg1_addr   ,
    input  logic [ADDR_WIDTH - 1:0] rs_reg2_addr   ,

    output logic [DATAWIDTH - 1:0] rs_reg1_rdata  ,
    output logic [DATAWIDTH - 1:0] rs_reg2_rdata
);
    // 寄存器堆的定义，由于测试需要使用该变量，请不要修改变量名称
    logic [DATAWIDTH - 1:0] reg_bank [31:0];

    always_ff (posedge clk or posedge rst) begin
        if (rst) begin
            // 重置寄存器堆
            for (int i = 0; i < 32; i++) begin
                reg_bank[i] <= 32'b0;
            end
        end
        else if (wr_reg_en) begin
            reg_bank[wr_reg_addr] <= wr_wdata; // 写入数据到寄存器堆
        end
    end

    // 从寄存器堆读取数据
    assign rs_reg1_rdata = reg_bank[rs_reg1_addr];
    assign rs_reg2_rdata = reg_bank[rs_reg2_addr];

endmodule
