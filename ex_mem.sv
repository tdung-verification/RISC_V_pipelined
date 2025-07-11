module ex_mem(
  input  logic i_clk, i_rst_n, i_stall, i_flush,
  input  logic [31:0] i_alu_dataE, i_rs2_dataE, i_pc_fourE, i_pcE,
  input  logic [4:0]  i_rd_addrE,
  input  logic i_insn_vldE,
  input  logic i_branch_takenE,
  output logic [31:0] o_alu_dataM, o_rs2_dataM, o_pc_fourM, o_pcM,
  output logic [4:0]  o_rd_addrM,
  output logic o_insn_vldM,
  output logic o_branch_takenM
);

  always_ff @(posedge i_clk) begin
    if (~i_rst_n || i_flush || i_stall) begin
	   o_alu_dataM     <= 32'b0;
		o_rs2_dataM     <= 32'b0;
		o_rd_addrM      <= 5'b0 ;
		o_pc_fourM      <= 32'b0;
		o_insn_vldM     <= 1'b0;
		o_pcM           <= 32'b0;
		o_branch_takenM <= 1'b0;
	 end
	 else begin
	   o_alu_dataM     <= i_alu_dataE;
		o_rs2_dataM     <= i_rs2_dataE;
		o_rd_addrM      <= i_rd_addrE ;
		o_pc_fourM      <= i_pc_fourE ;
		o_insn_vldM     <= i_insn_vldE;
		o_pcM           <= i_pcE      ;
		o_branch_takenM <= i_branch_takenE;
	 end
  end
endmodule