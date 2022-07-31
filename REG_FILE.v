module REG_FILE #(parameter Address_Width =5,parameter REG_Width =32,parameter Depth=2**Address_Width) (

    input wire CLK,
    input wire [Address_Width-1:0] A1,
    input wire [Address_Width-1:0] A2,
    input wire [Address_Width-1:0] A3,
    input wire [REG_Width-1:0] WD3,
    input wire WE3,
    input wire RST,
    output reg [REG_Width-1:0] RD1,
    output reg [REG_Width-1:0] RD2
);

reg [REG_Width-1:0] REGFILE [0:Depth-1];
integer i;
//read
always @(*) begin
    RD1=REGFILE[A1];
    RD2=REGFILE[A2];
end
//write 
always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        for(i=0;i<Depth;i=i+1)
        begin
           REGFILE[i]<=32'b0; 
        end
    end
    else if(WE3)
    begin
        REGFILE[A3]<=WD3;
    end
    else
    REGFILE[A3]<=REGFILE[A3];
end

    
endmodule
