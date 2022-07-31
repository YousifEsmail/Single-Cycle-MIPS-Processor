module _2bit_shifter #(parameter IN_WIDTH=32,parameter OUT_WIDTH=32)
(
    input wire [IN_WIDTH-1:0] IN,
    output reg [OUT_WIDTH-1:0] OUT
);
    
    always @(*) begin
        OUT=IN<<2;
    end
endmodule