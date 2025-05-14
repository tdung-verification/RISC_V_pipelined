module control (
  input  logic i_clk, i_rst_n, i_stall, i_flush,
  input  logic [31:0] i_inst,
  output logic o_rd_wrenM, o_rd_wrenW, o_lsu_wrenM, o_lsu_rdenE, o_jalE, o_branchE, o_opb_selE, o_alu_decE,
  output logic [1:0] o_opa_selE, o_wb_selW
);
  logic rd_wren, lsu_wren, lsu_rden, jal, branch, opb_sel, alu_dec;
  logic [1:0] opa_sel, wb_sel;
  logic rd_wrenD, lsu_wrenD, lsu_rdenD, jalD, branchD, opb_selD, alu_decD;
  logic [1:0] opa_selD, wb_selD;
  logic rd_wrenE, lsu_wrenE, lsu_rdenE, jalE, branchE, opb_selE, alu_decE;
  logic [1:0] opa_selE, wb_selE;
  logic rd_wrenM, lsu_wrenM;
  logic [1:0] wb_selM;
  logic rd_wrenW;
  logic [1:0] wb_selW;

  
  assign o_rd_wrenM  = rd_wrenM;  
  assign o_rd_wrenW  = rd_wrenW;
  assign o_lsu_wrenM = lsu_wrenM; 
  assign o_lsu_rdenE = lsu_rdenE;
  assign o_wb_selW   = wb_selW;
  assign o_jalE      = jalE;
  assign o_branchE   = branchE;
  assign o_opb_selE  = opb_selE;
  assign o_alu_decE  = alu_decE;
  assign o_opa_selE  = opa_selE;
  
  control_unit ctrlunit(
    .i_inst(i_inst),
    .o_rd_wren(rd_wren),
	 .o_lsu_wren(lsu_wren),
    .o_lsu_rden(lsu_rden),
    .o_wb_sel(wb_sel),
    .o_alu_dec(alu_dec),
    .o_jal(jal),
	 .o_branch(branch),
    .o_opa_sel(opa_sel),
    .o_opb_sel(opb_sel));
	
	always_comb begin
	  if(i_stall == 1'b1) begin
	    rd_wrenD  = 1'b0 ;
		 lsu_wrenD = 1'b0 ;
       lsu_rdenD = 1'b0 ;
		 wb_selD   = 2'b0 ;
		 alu_decD  = 1'b0 ;
		 jalD      = 1'b0 ;
		 branchD   = 1'b0 ;
		 opa_selD  = 2'b00;
		 opb_selD  = 1'b0 ;
	  end
	  else begin
	    rd_wrenD  = rd_wren;
		 lsu_wrenD = lsu_wren;
       lsu_rdenD = lsu_rden;
		 wb_selD   = wb_sel;
		 alu_decD  = alu_dec;
		 jalD      = jal;
		 branchD   = branch;
		 opa_selD  = opa_sel;
		 opb_selD  = opb_sel;
	  end
	end
	
  control_ff_DE ff_ID_EX(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
	 .i_flush(i_flush),
    .i_rd_wrenD(rd_wrenD),
	 .i_lsu_wrenD(lsu_wrenD),
    .i_lsu_rdenD(lsu_rdenD),
	 .i_wb_selD(wb_selD),
	 .i_jalD(jalD),
	 .i_branchD(branchD),
	 .i_opb_selD(opb_selD),
    .i_alu_decD(alu_decD),
	 .i_opa_selD(opa_selD),
    .o_rd_wrenE(rd_wrenE),
	 .o_lsu_wrenE(lsu_wrenE),
    .o_lsu_rdenE(lsu_rdenE),
	 .o_wb_selE(wb_selE),
	 .o_jalE(jalE),
	 .o_branchE(branchE),
	 .o_opb_selE(opb_selE),
    .o_alu_decE(alu_decE),
	 .o_opa_selE(opa_selE));
	 
  control_ff_EM ff_EX_MEM(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_rd_wrenE(rd_wrenE),
	 .i_lsu_wrenE(lsu_wrenE),
	 .i_wb_selE(wb_selE),
    .o_rd_wrenM(rd_wrenM),
	 .o_lsu_wrenM(lsu_wrenM),
	 .o_wb_selM(wb_selM));
  
  control_ff_MW ff_MEM_WB(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_rd_wrenM(rd_wrenM),
	 .i_wb_selM(wb_selM),
    .o_rd_wrenW(rd_wrenW),
	 .o_wb_selW(wb_selW));

endmodule