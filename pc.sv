module pc#(
    parameter   DATAWIDTH = 32
)(
    input  logic                   clk  ,
    input  logic                   rst  ,
    input  logic [DATAWIDTH - 1:0] npc  ,
    output logic [DATAWIDTH - 1:0] pc_out   
);
    always_ff @(posedge ck or posedge rst) begin
        if(rst) begin
            pc_out <= 32'b0;
        end
        else begin
            pc_out <= pc;
        end
    end
endmodule