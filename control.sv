  module control (
  input  logic i_clk, i_rst_n, i_stall, i_flush,
  input  logic [31:0] i_inst,
  output logic o_rd_wrenM, o_rd_wrenW, o_lsu_wrenM, o_lsu_rdenM, o_lsu_rdenW, o_jalE, o_branchE, o_jalM, o_branchM,
  output logic o_opb_selE, o_alu_decE, o_ctrl,
  output logic [1:0] o_opa_selE
);

  logic rd_wren,  lsu_rden,  jal,  branch,  lsu_wren,  opb_sel,  alu_dec ;
  logic [1:0] opa_sel;
  logic rd_wrenD, lsu_rdenD, jalD, branchD, lsu_wrenD, opb_selD, alu_decD;
  logic [1:0] opa_selD;
  logic rd_wrenE, lsu_rdenE, jalE, branchE, lsu_wrenE, opb_selE, alu_decE;
  logic [1:0] opa_selE;
  logic rd_wrenM, lsu_rdenM, jalM, branchM, lsu_wrenM;
  logic rd_wrenW, lsu_rdenW, jalW, branchW;

  
  assign o_rd_wrenM  = rd_wrenM;  
  assign o_rd_wrenW  = rd_wrenW;
  assign o_lsu_wrenM = lsu_wrenM; 
  assign o_lsu_rdenM = lsu_rdenM;
  assign o_lsu_rdenW = lsu_rdenW;
  assign o_jalE      = jalE;
  assign o_branchE   = branchE;
  assign o_jalM      = jalM;
  assign o_opb_selE  = opb_selE;
  assign o_alu_decE  = alu_decE;
  assign o_opa_selE  = opa_selE;
  assign o_branchM   = branchM;
  assign o_ctrl      = jalW || branchW;
  
  control_unit ctrlunit(
    .i_inst(i_inst),
    .o_rd_wren(rd_wren),
	 .o_lsu_wren(lsu_wren),
    .o_lsu_rden(lsu_rden),
    .o_alu_dec(alu_dec),
    .o_jal(jal),
	 .o_branch(branch),
    .o_opa_sel(opa_sel),
    .o_opb_sel(opb_sel));
	
	always_comb begin
	    rd_wrenD  = rd_wren;
		 lsu_wrenD = lsu_wren;
       lsu_rdenD = lsu_rden;
		 alu_decD  = alu_dec;
		 jalD      = jal;
		 branchD   = branch;
		 opa_selD  = opa_sel;
		 opb_selD  = opb_sel;
	end
	
  control_ff_DE ff_ID_EX(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
	 .i_stall(i_stall),
	 .i_flush(i_flush),
    .i_rd_wrenD(rd_wrenD),
	 .i_lsu_wrenD(lsu_wrenD),
    .i_lsu_rdenD(lsu_rdenD),
	 .i_jalD(jalD),
	 .i_branchD(branchD),
	 .i_opb_selD(opb_selD),
    .i_alu_decD(alu_decD),
	 .i_opa_selD(opa_selD),
    .o_rd_wrenE(rd_wrenE),
	 .o_lsu_wrenE(lsu_wrenE),
    .o_lsu_rdenE(lsu_rdenE),
	 .o_jalE(jalE),
	 .o_branchE(branchE),
	 .o_opb_selE(opb_selE),
    .o_alu_decE(alu_decE),
	 .o_opa_selE(opa_selE));
	 
  control_ff_EM ff_EX_MEM(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
	 .i_stall(i_stall),
	 .i_flush(i_flush),
    .i_rd_wrenE(rd_wrenE),
	 .i_lsu_wrenE(lsu_wrenE),
	 .i_lsu_rdenE(lsu_rdenE),
	 .i_jalE(jalE),
	 .i_branchE(branchE),
    .o_rd_wrenM(rd_wrenM),
	 .o_lsu_wrenM(lsu_wrenM),
	 .o_lsu_rdenM(lsu_rdenM),
	 .o_jalM(jalM),
	 .o_branchM(branchM));
  
  control_ff_MW ff_MEM_WB(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_rd_wrenM(rd_wrenM),
	 .i_lsu_rdenM(lsu_rdenM),
	 .i_jalM(jalM),
	 .i_branchM(branchM),
    .o_rd_wrenW(rd_wrenW),
	 .o_lsu_rdenW(lsu_rdenW),
	 .o_jalW(jalW),
	 .o_branchW(branchW));


endmodule