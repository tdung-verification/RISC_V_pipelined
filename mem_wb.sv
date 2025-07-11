module mem_wb(
  input  logic i_clk, i_rst_n,
  input  logic [31:0] i_ld_dataM, i_un_ld_dataM, i_pc_fourM, i_pcM,
  input  logic [4:0] i_rd_addrM,
  input  logic i_insn_vldM, i_mispredM,
  output logic [31:0] o_ld_dataW, o_un_ld_dataW, o_pc_fourW, o_pcW,
  output logic [4:0] o_rd_addrW,
  output logic o_insn_vldW, o_mispredW
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n) begin
	   o_ld_dataW    <= 32'b0;
	   o_un_ld_dataW <= 32'b0;
	   o_rd_addrW    <= 5'b0 ;
	   o_pc_fourW    <= 32'b0;
		o_insn_vldW   <= 1'b0;
		o_pcW         <= 32'b0;
		o_mispredW    <= 1'b0;
	 end
	 else begin
	   o_ld_dataW     <= i_ld_dataM    ;
	   o_un_ld_dataW  <= i_un_ld_dataM ;
	   o_rd_addrW     <= i_rd_addrM    ;
	   o_pc_fourW     <= i_pc_fourM    ;
		o_insn_vldW    <= i_insn_vldM   ;
		o_pcW          <= i_pcM;
		o_mispredW     <= i_mispredM   ;
	 end
  end
endmodule