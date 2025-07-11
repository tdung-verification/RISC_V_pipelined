module branch_comb(
  input  logic [31:0] i_rd1, i_rd2,
  input  logic [2:0]  i_funct3,
  input  logic        i_branch, i_jal,
  output logic        o_branch_taken
);
  
  logic br_jump;
  logic [31:0] sub_result;
  logic borrow, overflow, br_equal, br_less;
  assign {borrow, sub_result} = {1'b0,i_rd1} + ~{1'b0,i_rd2} + 33'b1;
  assign overflow = (i_rd1[31] & ~i_rd2[31] & ~sub_result[31]) | (~i_rd1[31] & i_rd2[31] & sub_result[31]);
  assign br_less  = (i_funct3[1]) ? borrow : (sub_result[31] ^ overflow); 
  assign br_equal = (i_rd1 == i_rd2); 
	  always_comb begin
       if(i_branch) begin
			if(i_funct3[2] == 1'b0) br_jump = (i_funct3[0]) ? ~br_equal : br_equal;
			else br_jump = (i_funct3[0]) ? ~br_less : br_less;
		 end
		 else br_jump = 1'b0;
	  end
	  
	  assign o_branch_taken = i_jal || br_jump;
	endmodule