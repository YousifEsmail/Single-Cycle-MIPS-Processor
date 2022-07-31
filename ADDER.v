module ADDER #(parameter DATA_WIDTH =32)
(
    input wire [DATA_WIDTH-1:0] A,
    input wire [DATA_WIDTH-1:0] B,
    output reg [DATA_WIDTH-1:0] C 
);
    always @(*) begin
        C=A+B;
    end
endmodule
