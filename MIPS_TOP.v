module MIPS_TOP #(parameter INST_WIDTH =32,
parameter DATA_WIDTH= 32)
(
    input wire CLK,
    input wire RST,
    output wire [15:0] test_value_top
);

//internal connections
//Controlunit==>datapath
wire [5:0] Opcode_top;
wire [5:0] Funct_top;
wire zero_top;
wire RegWrite_top;
wire RegDst_top;
wire ALUSrc_top;
wire MemtoReg_top;
wire PCSRC_top;
wire [2:0] ALUControl_top;
wire jump_top;  

//datapath==>Memories
//inst_mem
wire [INST_WIDTH-1:0] PC_Top;
//data_Mem
wire [DATA_WIDTH-1:0] ALUResult_Top;
wire [DATA_WIDTH-1:0] Write_DATA_Top;

//Control==>Data_Mem
wire MemWrite_top;

//istrMem==>DataPath
wire [INST_WIDTH-1:0] INSTR_top;


//DataMem==>Datapath
wire [DATA_WIDTH-1:0] READ_DATA_top;





CONTROL_UNIT u_CONTROL_UNIT(
    .Opcode     (INSTR_top[31:26]),
    .Funct      (INSTR_top[5:0]),
    .zero       (zero_top),
    .MemWrite   (MemWrite_top),
    .RegWrite   (RegWrite_top),
    .RegDst     (RegDst_top),
    .ALUSrc     (ALUSrc_top),
    .MemtoReg   (MemtoReg_top ),
    .PCSRC      (PCSRC_top ),
    .ALUControl (ALUControl_top),
    .jump       (jump_top)
);


DATA_PATH #(
    .INST_WIDTH                (INST_WIDTH                ),
    .DATA_WIDTH                (DATA_WIDTH                )
)
u_DATA_PATH(
    .CLK           (CLK           ),
    .RST           (RST           ),
    .INSTR_DP      (INSTR_top      ),
    .READ_DATA_DP  (READ_DATA_top  ),
    .ALUControl_DP (ALUControl_top ),
    .jump_DP       (jump_top      ),
    .PCSRC_DP      (PCSRC_top      ),
    .MemtoReg_DP   (MemtoReg_top   ),
    .ALUSrc_DP     (ALUSrc_top     ),
    .RegDst_DP     (RegDst_top     ),
    .RegWrite_DP   (RegWrite_top   ),
    .PC_DP         (PC_Top),
    .Write_DATA_DP (Write_DATA_Top ),
    .ALUResult_DP  (ALUResult_Top  ),
    .zero_Dp       (zero_top       )
);


INST_MEM #()
u_INST_MEM(
    .pc_instUnit (PC_Top ),
    .INSTR       (INSTR_top )
);



DATA_MEM #(
)
u_DATA_MEM(
    .CLK        (CLK),
    .A          (ALUResult_Top),
    .WD         (Write_DATA_Top),
    .WE         (MemWrite_top),
    .RST        (RST),
    .RD         (READ_DATA_top),
    .test_value (test_value_top)
);





endmodule