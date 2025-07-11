module control_ff_MW(
  input  logic i_clk, i_rst_n,
  input  logic i_rd_wrenM, i_lsu_rdenM, i_jalM, i_branchM,
  output logic o_rd_wrenW, o_lsu_rdenW, o_jalW, o_branchW
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n) begin
	   o_rd_wrenW    <= 1'b0 ;
		o_lsu_rdenW   <= 1'b0 ;
		o_branchW     <= 1'b0 ;
		o_jalW        <= 1'b0 ;
	 end
	 else begin
	   o_rd_wrenW    <= i_rd_wrenM  ;
		o_lsu_rdenW   <= i_lsu_rdenM ;
		o_branchW     <= i_branchM   ;
		o_jalW        <= i_jalM      ;
	 end
  end
endmodule