module DATA_PATH #(parameter INST_WIDTH =32,parameter DATA_WIDTH= 32) (
    input wire CLK, 
    input wire RST,
    input wire [INST_WIDTH-1:0] INSTR_DP,
    input wire [DATA_WIDTH-1:0] READ_DATA_DP,
    input wire [2:0] ALUControl_DP,
    input wire jump_DP,
    input wire PCSRC_DP,
    input wire MemtoReg_DP,
    input wire ALUSrc_DP,
    input wire RegDst_DP,
    input wire RegWrite_DP,

    output wire [INST_WIDTH-1:0] PC_DP,
    output wire [DATA_WIDTH-1:0] Write_DATA_DP,
    output wire [DATA_WIDTH-1:0] ALUResult_DP,

    output wire zero_Dp

);

// paramters
parameter u1_shifter_data_width =32;
parameter u2_shifter_in_data_width =26;
parameter u2_shifter_out_data_width =28;
parameter Mux_inputWidth_large = 32;
parameter Mux_inputWidth_small = 5;

//internalcoonections
wire [DATA_WIDTH-1:0] SrcA_inter;
wire [DATA_WIDTH-1:0] SrcB_inter;
wire [DATA_WIDTH-1:0] SignImm_inter ;
wire [Mux_inputWidth_small-1:0] MUX4_out;
wire [Mux_inputWidth_large-1:0] MUX1_out;
wire [Mux_inputWidth_large-1:0] MUX5_out;

wire [u1_shifter_data_width-1:0] u1__2bit_shifter_OUT;
wire [u2_shifter_out_data_width-1:0] u2__2bit_shifter_OUT;

wire [INST_WIDTH-1:0] PC_BRANCH ;
wire [INST_WIDTH-1:0] PC_PLUS4 ;
wire [INST_WIDTH-1:0] p_c_internal;


wire [INST_WIDTH-1:0] PC_JUMP ;

assign PC_JUMP={PC_PLUS4[31:28],u2__2bit_shifter_OUT};


REG_FILE #()
u_REG_FILE(
    .CLK (CLK ),
    .RST (RST ),
    .A1  (INSTR_DP[25:21]),
    .A2  (INSTR_DP[20:16]),
    .A3  (MUX4_out),
    .WD3 (MUX5_out),
    .WE3 (RegWrite_DP),
    .RD1 (SrcA_inter),
    .RD2 (Write_DATA_DP)
);

ALU #(.DATA_WIDTH (DATA_WIDTH ))
u_ALU(
    .SrcA       (SrcA_inter),
    .SrcB       (SrcB_inter),
    .ALUControl (ALUControl_DP ),
    .zero       (zero_Dp),
    .ALUResult  (ALUResult_DP)
);


MUX #(.input_width (Mux_inputWidth_large))
u1_MUX(
    .IN1 (PC_PLUS4),
    .IN2 (PC_BRANCH),
    .SEL (PCSRC_DP),
    .OUT (MUX1_out )
);



MUX #(.input_width (Mux_inputWidth_large))
u2_MUX(
    .IN1 (MUX1_out),
    .IN2 (PC_JUMP ),
    .SEL (jump_DP ),
    .OUT (p_c_internal)
);



MUX #(.input_width (Mux_inputWidth_large))
u3_MUX(
    .IN1 (Write_DATA_DP),
    .IN2 (SignImm_inter),
    .SEL (ALUSrc_DP),
    .OUT (SrcB_inter)
);


MUX #(.input_width (Mux_inputWidth_small))
u4_MUX(
    .IN1 (INSTR_DP[20:16]),
    .IN2 (INSTR_DP[15:11] ),
    .SEL (RegDst_DP ),
    .OUT (MUX4_out)
);



MUX #(.input_width (Mux_inputWidth_large))
u5_MUX(
    .IN1 (ALUResult_DP),
    .IN2 (READ_DATA_DP ),
    .SEL (MemtoReg_DP),
    .OUT (MUX5_out)
);




Sign_EXT #(
    .DATA_WIDTH   (DATA_WIDTH)
)
u_Sign_EXT(
    .INSTR   (INSTR_DP[15:0]),
    .SignImm (SignImm_inter)
);


_2bit_shifter #(
    .IN_WIDTH  (u1_shifter_data_width),
    .OUT_WIDTH (u1_shifter_data_width)
)
u1__2bit_shifter(
    .IN  (SignImm_inter ),
    .OUT (u1__2bit_shifter_OUT )
);


_2bit_shifter #(
    .IN_WIDTH  (u2_shifter_in_data_width),
    .OUT_WIDTH (u2_shifter_out_data_width)
)
u2__2bit_shifter(
    .IN  (INSTR_DP[25:0] ),
    .OUT (u2__2bit_shifter_OUT )
);



ADDER #(
    .DATA_WIDTH (DATA_WIDTH )
)
u1_ADDER(
    .A (u1__2bit_shifter_OUT),
    .B (PC_PLUS4),
    .C (PC_BRANCH)
);


ADDER #(
    .DATA_WIDTH (DATA_WIDTH )
)
u2_ADDER(
    .A (PC_DP),
    .B (32'b100),
    .C (PC_PLUS4)
);


PC #(
    .inst_Width (INST_WIDTH)
)
u_PC(
    .CLK (CLK ),
    .RST (RST ),
    .p_c (p_c_internal),
    .pc  (PC_DP)
);




endmodule
    
