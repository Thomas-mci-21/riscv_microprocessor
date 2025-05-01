module npc#(
    parameter WIDTH = 32 
)(
    input logic Pcsrc;
    input logic [WIDTH-1:0] pc;
    input logic [WIDTH-1:0] imme;
    output logic [WIDTH-1:0] npc
);

    always_comb begin 
        npc = Pcsrc?pc+imme:pc+4;
    end
endmodule