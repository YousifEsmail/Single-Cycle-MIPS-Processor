module INST_MEM #(parameter inst_width =32 ) 
(
    input wire [inst_width-1:0] pc_instUnit,
    output reg [inst_width-1:0] INSTR

);
    
reg [inst_width-1:0] INST_mem [0:inst_width-1];

//==========ProgramFlashing=============
initial
    begin
    $readmemh ("Program 1_MachineCode.txt",INST_mem);
    end

//=====================
always @(*) begin
    INSTR=INST_mem[pc_instUnit>>2];
end

endmodule
