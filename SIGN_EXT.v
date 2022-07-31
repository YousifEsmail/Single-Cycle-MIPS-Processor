module Sign_EXT #(parameter DATA_WIDTH =32,parameter Un_EXT_WIDTH=16)
(
    input wire [Un_EXT_WIDTH-1:0] INSTR,
    output reg [DATA_WIDTH-1:0] SignImm
);

always @(*) begin
    // replecate the sign "INSTR[Un_EXT_WIDTH-1]" ==> DATA_WIDTH-Un_EXT_WIDTH times 
    //the concat it INSTR
    SignImm={({(DATA_WIDTH-Un_EXT_WIDTH){INSTR[Un_EXT_WIDTH-1]}}),INSTR};//replicate inside concat
end
    
endmodule