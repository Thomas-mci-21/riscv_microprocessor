module mux#(
    parameter WIDTH = 32
)(
    input  logic [WIDTH - 1:0] A          ,
    input  logic [WIDTH - 1:0] B          ,
    input  logic Control                  ,
    output logic [WIDTH - 1:0] Result
);

    always_comb begin
        Result = Control?A:B;
    end
endmodule