module control_ff_EM(
  input  logic i_clk, i_rst_n, i_stall, i_flush,
  input  logic i_rd_wrenE, i_lsu_wrenE, i_lsu_rdenE, i_jalE, i_branchE,
  output logic o_rd_wrenM, o_lsu_wrenM, o_lsu_rdenM, o_jalM, o_branchM
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n || i_stall || i_flush) begin
	   o_rd_wrenM  <= 1'b0 ;
		o_lsu_wrenM <= 1'b0 ;
		o_lsu_rdenM <= 1'b0 ;
		o_jalM      <= 1'b0 ;
      o_branchM   <= 1'b0 ;
	 end
	 else begin
	   o_rd_wrenM  <= i_rd_wrenE  ;
		o_lsu_wrenM <= i_lsu_wrenE ;
		o_lsu_rdenM <= i_lsu_rdenE ;
		o_jalM      <= i_jalE      ;
      o_branchM   <= i_branchE   ;
	 end
  end
endmodule