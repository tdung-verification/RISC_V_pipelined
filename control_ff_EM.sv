module control_ff_EM(
  input  logic i_clk, i_rst_n,
  input  logic i_rd_wrenE, i_lsu_wrenE,
  input  logic [1:0] i_wb_selE,
  output logic o_rd_wrenM, o_lsu_wrenM, 
  output logic [1:0] o_wb_selM
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n) begin
	   o_rd_wrenM  <= 1'b0 ;
		o_lsu_wrenM <= 1'b0 ;
		o_wb_selM   <= 2'b0 ;
	 end
	 else begin
	   o_rd_wrenM  <= i_rd_wrenE ;
		o_lsu_wrenM <= i_lsu_wrenE;
		o_wb_selM   <= i_wb_selE  ;
	 end
  end
endmodule