module DATA_MEM #(parameter Address_Width =32,parameter REG_Width =32,parameter Depth=100) 
(

    input wire CLK,
    input wire [Address_Width-1:0] A,
    input wire [REG_Width-1:0] WD,
    input wire WE,
    input wire RST,
    output reg [REG_Width-1:0] RD,
    output reg [15:0] test_value
);

reg [REG_Width-1:0] DATA_mem [0:Depth-1];
integer i;
//read
always @(*) begin
    RD=DATA_mem[A];
end
//write 
always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        for(i=0;i<Depth;i=i+1)
        begin
           DATA_mem[i]<=32'b0; 
        end
    end
    else if(WE)
    begin
        DATA_mem[A]<=WD;
    end
    else
    DATA_mem[A]<=DATA_mem[A];
end

always @(*) begin
 test_value=DATA_mem[0];   
end
 

    
endmodule

