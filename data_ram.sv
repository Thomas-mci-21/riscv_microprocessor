`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/13 09:59:48
// Design Name: 
// Module Name: data_ram
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


module data_ram #(
    parameter   DATAWIDTH   =   32  ,
    parameter   RAMWIDTH    =   8   ,
    parameter   RAMDEPTH    =   8  
)(
    input  logic                   clk      ,
    input  logic                   rst      ,
    input  logic                   ena      ,
    input  logic                   wen      ,
    input  logic [DATAWIDTH - 1:0] din      ,
    input  logic [DATAWIDTH - 1:0] daddr    ,
    output logic [DATAWIDTH - 1:0] dout     
);
    // 先用reg进行最简单的模拟，这段代码不会将reg综合为bram
    reg [RAMWIDTH - 1:0] ram [2**(RAMDEPTH) - 1:0];

    localparam BYTES_PER_WORD = DATAWIDTH / RAMWIDTH;
    
    
    // ----------- 异步读逻辑（组合逻辑） ------------
    always_comb begin
        if (ena) begin
            for (int i = 0; i < BYTES_PER_WORD; i++) begin
                dout[i*RAMWIDTH +: RAMWIDTH] = ram[daddr + i];
            end
        end else begin
            dout = '0;
        end
    end

    // ----------- 同步写逻辑（时序逻辑） ------------
    always_ff @(posedge clk) begin
        if (rst) begin
            // 全部复位为0
            for (int i = 0; i < 2**RAMDEPTH; i++) begin
                ram[i] <= '0;
            end
        end else if (ena && wen) begin
            for (int i = 0; i < BYTES_PER_WORD; i++) begin
                ram[daddr + i] <= din[i*RAMWIDTH +: RAMWIDTH];
            end
        end
    end


endmodule
