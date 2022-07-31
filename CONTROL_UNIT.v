module CONTROL_UNIT (
    input wire [5:0] Opcode,
    input wire [5:0] Funct,
    input wire zero,
    output wire MemWrite,
    output wire RegWrite,
    output wire RegDst,
    output wire ALUSrc,
    output wire MemtoReg,
    output wire PCSRC,
    output wire [2:0] ALUControl,
    output wire jump  
);

wire [1:0] ALUOp_Maindec_aludec;
wire  Branch_inter;

MAIN_DECODER MAIN_DECODER_U1 
(
    .Opcode(Opcode),
    .ALUOp(ALUOp_Maindec_aludec),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .Branch(Branch_inter),
    .ALUSrc(ALUSrc),
    .RegDst(RegDst),
    .RegWrite(RegWrite),
    .jump(jump)
);

assign PCSRC=zero&Branch_inter;

ALU_DEC ALU_DEC_U1 
(
.ALUOp(ALUOp_Maindec_aludec),
.Funct(Funct),
.ALUControl(ALUControl)
);
    
endmodule
