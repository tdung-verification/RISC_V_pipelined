module branch_prediction(
  input  logic        i_clk, i_rst_n,
  input  logic [31:0] i_PC_IF, i_PC_ID, i_PC_EX,
  input  logic [31:0] i_br_PC_EX,
  input  logic [31:0] i_inst_IF,
  input  logic        i_branch_taken_EX,
  input  logic        i_stall,
  input  logic        i_is_br_EX, i_is_jump_EX,
  output logic [31:0] o_next_PC,
  output logic        o_flush
);
  logic [9:0] index_IF;
  logic [19:0] tag_IF, tag_predicted;
  logic [31:0] PC_predicted, predict_new_PC;
  logic valid;
  logic predict_taken;
  logic hit;
  logic is_br_IF, is_jump_IF;

  logic [9:0] index_EX;
  logic [19:0] tag_EX;
  logic [31:0] expected_PC;
//
  assign is_br_IF   = (i_inst_IF[6:2] == 5'b11000);
  assign is_jump_IF = (i_inst_IF[6:2] == 5'b11011 | i_inst_IF[6:2] == 5'b11001);
// read
  assign index_IF = i_PC_IF[11:2] ;
  assign tag_IF   = i_PC_IF[31:12];
  assign hit = (tag_IF == tag_predicted) ;
  assign predict_new_PC = ((is_jump_IF | (is_br_IF & predict_taken)) & hit & valid) ? PC_predicted : i_PC_IF + 32'd4;
  assign o_next_PC = (o_flush) ? expected_PC : predict_new_PC;
//write_update_btb
  assign index_EX = i_PC_EX[11:2];
  assign tag_EX   = i_PC_EX[31:12];
//flush
  assign expected_PC = (i_branch_taken_EX) ? i_br_PC_EX : i_PC_EX + 32'd4;
  assign o_flush = (i_is_br_EX | i_is_jump_EX) & (i_PC_ID != expected_PC);

  btb btb_mem(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_addr_rd_table(index_IF),
    .i_addr_wr_table(index_EX),
    .i_tag(tag_EX),
    .i_predicted_pc(i_br_PC_EX),
    .i_wren(i_is_br_EX | i_is_jump_EX),
    .o_tag(tag_predicted),
    .o_predicted_pc(PC_predicted),
    .o_valid(valid)
   );
// ALWAYS TAKEN
  assign predict_taken = 1'b1;
endmodule