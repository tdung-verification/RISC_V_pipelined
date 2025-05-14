module control_ff_MW(
  input  logic i_clk, i_rst_n,
  input  logic i_rd_wrenM,
  input  logic [1:0] i_wb_selM, 
  output logic o_rd_wrenW,
  output logic [1:0] o_wb_selW
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n) begin
	   o_rd_wrenW  <= 1'b0 ;
		o_wb_selW   <= 2'b0 ;
	 end
	 else begin
	   o_rd_wrenW  <= i_rd_wrenM  ;
		o_wb_selW   <= i_wb_selM   ;
	 end
  end
endmodule