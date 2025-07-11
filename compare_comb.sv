module compare_comb(
  input  logic [31:0] i_rd1, i_rd2,
  input  logic        i_br_un,
  output logic        o_br_equal, o_br_less
);

  logic [31:0] sub_result;
  logic borrow, overflow;
  assign {borrow, sub_result} = {1'b0,i_rd1} + ~{1'b0,i_rd2} + 33'b1;
  assign overflow = (i_rd1[31] & ~i_rd2[31] & ~sub_result[31]) | (~i_rd1[31] & i_rd2[31] & sub_result[31]);
//output
  assign o_br_less  = (i_br_un) ? borrow : (sub_result[31] ^ overflow); 
  assign o_br_equal = (i_rd1 == i_rd2); 

endmodule