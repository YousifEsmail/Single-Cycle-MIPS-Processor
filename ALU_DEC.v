module ALU_DEC (
    input wire[1:0] ALUOp,
    input wire [5:0] Funct,
    output reg [2:0] ALUControl  
);

  always @(*) begin
      case (ALUOp)
      2'b00:ALUControl=3'b010;
      2'b01:ALUControl=3'b100;
      2'b10:
            begin
               case (Funct)
                   6'b10_0000:ALUControl=3'b010;
                   6'b10_0010:ALUControl=3'b100;
                   6'b10_1010:ALUControl=3'b110;
                   6'b01_1100:ALUControl=3'b101;
                    default: ALUControl=3'b010;
                endcase 
            end
       default: ALUControl=3'b010;
  endcase 
      
  end 

endmodule
