module MUX #(parameter input_width =32) (
    input  wire [input_width-1:0] IN1,
    input  wire [input_width-1:0] IN2,
    input  wire SEL,
    output reg [input_width-1:0] OUT
);
    

always @(*) begin
    if(SEL)
    OUT=IN2;
    else
    OUT=IN1;

end
    
endmodule
