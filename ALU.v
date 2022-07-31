module ALU #(parameter DATA_WIDTH =32) (
    input wire [DATA_WIDTH-1:0] SrcA ,
    input wire [DATA_WIDTH-1:0] SrcB ,
    input wire [2:0] ALUControl,
    output wire zero,
    output reg [DATA_WIDTH-1:0] ALUResult 
);

always @(*) begin
    case (ALUControl)
        3'b000: ALUResult=SrcA & SrcB;
        3'b001: ALUResult=SrcA | SrcB;
        3'b010: ALUResult=SrcA + SrcB;
        3'b011: ALUResult='b0;
        3'b100: ALUResult=SrcA - SrcB;
        3'b101: ALUResult=SrcA * SrcB;
        3'b110: ALUResult=((SrcA-SrcB))>>(DATA_WIDTH-1);
        3'b111: ALUResult='b0;
        default: ALUResult='b0;
    endcase

end

assign zero=(ALUResult=='b0);
    
endmodule