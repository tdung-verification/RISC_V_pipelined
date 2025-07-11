module control_ff_DE(
  input  logic i_clk, i_rst_n, i_flush, i_stall,
  input  logic i_rd_wrenD, i_lsu_wrenD, i_lsu_rdenD, i_jalD, i_branchD, i_opb_selD, i_alu_decD,
  input  logic [1:0] i_opa_selD,
  output logic o_rd_wrenE, o_lsu_wrenE, o_lsu_rdenE, o_jalE, o_branchE, o_opb_selE, o_alu_decE,
  output logic [1:0] o_opa_selE
);
  always_ff @(posedge i_clk) begin
    if ((~i_rst_n)||i_flush) begin
	   o_rd_wrenE  <= 1'b0 ;
		o_lsu_wrenE <= 1'b0 ;
		o_lsu_rdenE <= 1'b0 ;
		o_jalE      <= 1'b0 ;
		o_branchE   <= 1'b0 ;
		o_opa_selE  <= 2'b00;
		o_opb_selE  <= 1'b0 ;
		o_alu_decE  <= 1'b0 ;
	 end
	 else if (i_stall == 1'b0 )begin
	   o_rd_wrenE  <= i_rd_wrenD ;
		o_lsu_wrenE <= i_lsu_wrenD;
		o_lsu_rdenE <= i_lsu_rdenD;
		o_jalE      <= i_jalD     ;
		o_branchE   <= i_branchD  ;
		o_opa_selE  <= i_opa_selD ;
		o_opb_selE  <= i_opb_selD ;
		o_alu_decE  <= i_alu_decD ;
	 end
  end
endmodule