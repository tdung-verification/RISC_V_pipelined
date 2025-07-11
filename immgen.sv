module immgen (
  input  logic [31:0] i_inst,
  output logic [31:0] o_imm
);
  logic [6:0] opcode;
  assign opcode = i_inst[6:0];
  always_comb begin
    case(opcode)
		7'b0010011: o_imm = {{21{i_inst[31]}},i_inst[30:20]};//I-type
		7'b0000011: o_imm = {{21{i_inst[31]}},i_inst[30:20]};//Load-type
		7'b0100011: o_imm = {{21{i_inst[31]}},i_inst[30:25],i_inst[11:7]};//s_type
		7'b1100011: o_imm = {{20{i_inst[31]}},i_inst[7],i_inst[30:25],i_inst[11:8],1'b0};//b-type
		7'b1101111: o_imm = {{12{i_inst[31]}},i_inst[19:12],i_inst[20],i_inst[30:21],1'b0};//j-type
		7'b0110111, 7'b0010111 : o_imm = {i_inst[31:12],12'b0};//u-type : lui, auipc
		7'b1100111: o_imm = {{21{i_inst[31]}},i_inst[30:20]};//jalr
		default:    o_imm = 32'b0;
	 endcase
  end
endmodule