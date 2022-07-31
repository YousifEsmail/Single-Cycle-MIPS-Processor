module MAIN_DECODER (
    input wire[5:0] Opcode,
    output reg [1:0] ALUOp ,
    output reg MemtoReg,
    output reg MemWrite,
    output reg Branch,
    output reg ALUSrc,
    output reg RegDst,
    output reg RegWrite,
    output reg jump
);

always @(*) begin
      case (Opcode)
       6'b10_0011 : 
       begin
        //loadWord
           jump=0;
           ALUOp=2'b00;
           MemWrite=0;
           RegWrite=1;//==>has_value
           RegDst=0;
           ALUSrc=1;//==>has_value
           MemtoReg=1;//==>has_value
           Branch=0;
       end
       6'b10_1011 : 
       begin
           //storeWord
           jump=0;
           ALUOp=2'b00;
           MemWrite=1;//==>has_value
           RegWrite=0;
           RegDst=0;
           ALUSrc=1;//==>has_value
           MemtoReg=1;//==>has_value
           Branch=0;
       end
       6'b00_0000 : 
       begin
           //rType
           jump=0;
           ALUOp=2'b10;//==>has_value
           MemWrite=0;
           RegWrite=1;//==>has_value
           RegDst=1;//==>has_value
           ALUSrc=0;
           MemtoReg=0;
           Branch=0;
       end
       6'b00_1000 : 
       begin
           //addImmediate
           jump=0;
           ALUOp=2'b00;
           MemWrite=0;
           RegWrite=1;//==>has_value
           RegDst=0;
           ALUSrc=1;//==>has_value
           MemtoReg=0;
           Branch=0;
       end
       6'b00_0100 : 
       begin
           //beq
           jump=0;
           ALUOp=2'b01;//==>has_value
           MemWrite=0;
           RegWrite=0;
           RegDst=0;
           ALUSrc=0;
           MemtoReg=0;
           Branch=1;//==>has_value
       end
       6'b00_0010 : 
       begin
           //jump_inst
           jump=1;
           ALUOp=2'b00;
           MemWrite=0;
           RegWrite=0;
           RegDst=0;
           ALUSrc=0;
           MemtoReg=0;
           Branch=0;
       end
        default:
        begin
            jump=0;
           ALUOp=2'b00;
           MemWrite=0;
           RegWrite=0;
           RegDst=0;
           ALUSrc=0;
           MemtoReg=0;
           Branch=0;
        end 
        
    endcase
end
    
endmodule
