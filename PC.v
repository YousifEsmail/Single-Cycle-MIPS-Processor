module PC #(parameter inst_Width =32) (
    input wire CLK,
    input wire RST,
    input wire [inst_Width-1:0] p_c,
    output reg [inst_Width-1:0] pc
);
    always @(posedge CLK or negedge RST ) begin
        if (!RST) begin
            pc<=32'b0;
            end
        else
            begin
            pc<=p_c;    
            end
    end

endmodule

