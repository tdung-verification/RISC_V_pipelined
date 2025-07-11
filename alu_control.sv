

/*
  alu_op = 
  ADD  0000
  SUB  0001
  SLL  0010
  SLT  0011
  SLTU 0100
  XOR  0101
  SRL  0110
  SRA  0111
  OR   1000
  AND  1001
  STAY 1010 for lui
*/
module alu_control(
  input  logic       i_alu_dec,
  input  logic [2:0] i_funct3,
  input  logic       i_funct7,i_opcode5,
  output logic [3:0]  o_alu_op
);

  always_comb begin
    case(i_alu_dec)
	   1'b0: o_alu_op = 4'b0000;
	   1'b1:  //R-type,Itype
		  case(i_funct3)
		    3'b000: o_alu_op = ((i_funct7 == 1'b1) && (i_opcode5 == 1'b1)) ? 4'b0001 : 4'b0000; //ADD, SUB
			 3'b001: o_alu_op = 4'b0010; //SLL
			 3'b010: o_alu_op = 4'b0011; //SLT
			 3'b011: o_alu_op = 4'b0100; //SLTU
			 3'b100: o_alu_op = 4'b0101; //XOR
			 3'b101: o_alu_op = (i_funct7 == 1'b0) ? 4'b0110 : 4'b0111; //SRL, SRA
			 3'b110: o_alu_op = 4'b1000; //OR
			 3'b111: o_alu_op = 4'b1001; //AND
		    default: o_alu_op = 4'b0000;
		  endcase
		default: o_alu_op = 4'b0000;
	 endcase
  end
endmodule