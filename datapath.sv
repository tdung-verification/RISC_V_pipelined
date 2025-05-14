module datapath(
  input  logic i_clk, i_rst_n,
  input  logic i_rd_wrenM, i_rd_wrenW, i_lsu_wrenM, i_jalE, i_branchE, i_opb_selE, i_lsu_rdenE,i_alu_decE,
  input  logic [1:0] i_opa_selE, i_wb_selW,
  input  logic [31:0] i_io_sw,
  output logic [31:0] o_io_ledr, o_io_ledg,
  output logic [31:0] o_inst,
  output logic o_stall, o_flush,
  output logic [31:0] nextpcF,instF,
  output logic [31:0] instD, pcD,
  output logic [31:0] rs1_dataD, rs2_dataD, immD,
  output logic [31:0] rs1_dataE, rs2_dataE, alu_dataE, immE,
  output logic [4:0]  rs1_addrE, rs2_addrE, rd_addrE, rd_addrM,
  output logic [31:0] alu_dataM, rs2_dataM,
  output logic [31:0] pcE, pc_fourE,
  output logic [1:0] forward_a_sel, forward_b_sel,
  output logic [3:0]  alu_op,
  output logic [31:0] operand_a, operand_b,
  output logic [2:0]  funct3E,
  output logic        funct7E, opcode5E, branch_takenE,
  output logic [31:0] rd_dataW, ld_dataW, alu_dataW,
  output logic [4:0]  rd_addrW,
  output logic [31:0] data_forward_a, data_forward_b,
  output logic [31:0]  pcF, pc_fourF, pc_fourD, pc_fourM, pc_fourW

);


  // IF

 
  // ID


  
  // EX

  //MEM
  
  logic [31:0] ld_dataM;
  
  //WB

  
  //hazard
  logic stall, flush;
  
  //IF stage

  program_counter pcunit(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
	 .i_stall(stall),
    .i_nextpc(nextpcF),
    .o_pc(pcF));
	 
  assign pc_fourF = pcF + 32'd4;
  
  branch_prediction  prediction(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_PC_IF(pcF),
	 .i_PC_ID(pcD),
	 .i_PC_EX(pcE),
    .i_br_PC_EX(alu_dataE),
    .i_inst_IF(instF),
    .i_branch_taken_EX(branch_takenE),
    .i_stall(stall),
    .i_is_br_EX(i_branchE),
	 .i_is_jump_EX(i_jalE),
    .o_next_PC(nextpcF),
    .o_flush(flush)
);
  
  instmemory imem(
    .addr(pcF),
    .rdata(instF));
	 
  if_id flip_flop_FD(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
	 .i_flush(flush),
	 .i_stall(stall),
    .i_pcF(pcF),
	 .i_instF(instF),
	 .i_pc_fourF(pc_fourF),
    .o_pcD(pcD),
	 .o_instD(instD),
	 .o_pc_fourD(pc_fourD));
	 
  //ID stage
  regfile registerfile(
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_rs1_addr(instD[19:15]),
	 .i_rs2_addr(instD[24:20]),
    .i_rd_addr(rd_addrW), 
    .i_rd_data(rd_dataW),
    .i_rd_wren(i_rd_wrenW),
    .o_rs1_data(rs1_dataD),
	 .o_rs2_data(rs2_dataD));
  
  immgen immunit(
    .i_inst(instD),
    .o_imm(immD));
	 
  id_ex flip_flop_DE(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
	 .i_flush(flush),
    .i_pcD(pcD),
	 .i_rs1_addrD(instD[19:15]),
	 .i_rs2_addrD(instD[24:20]),
	 .i_rs1_dataD(rs1_dataD),
	 .i_rs2_dataD(rs2_dataD),
	 .i_immD(immD),
	 .i_pc_fourD(pc_fourD), 
    .i_rd_addrD(instD[11:7]),
    .i_funct3D(instD[14:12]),
    .i_funct7D(instD[30]),
	 .i_opcode5D(instD[5]),
    .o_pcE(pcE),
	 .o_pc_fourE(pc_fourE),
	 .o_rs1_addrE(rs1_addrE),
	 .o_rs2_addrE(rs2_addrE),
	 .o_rs1_dataE(rs1_dataE),
	 .o_rs2_dataE(rs2_dataE),
	 .o_immE(immE),
    .o_rd_addrE(rd_addrE),
    .o_funct3E(funct3E),
    .o_funct7E(funct7E),
	 .o_opcode5E(opcode5E));
	 
  //EX stage

  mux3to1 muxa_forward(
    .i_a(rs1_dataE),
	 .i_b(alu_dataM),
	 .i_c(rd_dataW),
    .i_sel(forward_a_sel),
    .o_y(data_forward_a));
	 
  mux3to1 muxb_forward(
    .i_a(rs2_dataE),
	 .i_b(alu_dataM),
	 .i_c(rd_dataW),
    .i_sel(forward_b_sel),
    .o_y(data_forward_b));
	 
  mux3to1 muxa(
    .i_a(data_forward_a),
	 .i_b(pcE),
	 .i_c(32'b0),
    .i_sel(i_opa_selE),
    .o_y(operand_a));
	 
  assign operand_b = (i_opb_selE) ? immE: data_forward_b;
  
  branch_comb compare_comb(
    .i_rd1(data_forward_a),
	 .i_rd2(data_forward_b),
    .i_funct3(funct3E),
    .i_branch(i_branchE),
	 .i_jal(i_jalE),
    .o_branch_taken(branch_takenE)
);
  
  alu_control alu_control_unit(
    .i_alu_dec(i_alu_decE),
    .i_funct3(funct3E),
    .i_funct7(funct7E),
	 .i_opcode5(opcode5E),
    .o_alu_op(alu_op));
  
  alu alu_unit(
    .i_operand_a(operand_a),
	 .i_operand_b(operand_b),
    .i_alu_op(alu_op),
    .o_alu_data(alu_dataE)
  );
  
  forwarding_unit hazard_forwarding(
    .i_rs1_addrE(rs1_addrE),
	 .i_rs2_addrE(rs2_addrE),
    .i_rd_addrM(rd_addrM), 
	 .i_rd_addrW(rd_addrW),
    .i_rd_wrenM(i_rd_wrenM), 
	 .i_rd_wrenW(i_rd_wrenW),
    .o_forward_a(forward_a_sel), 
	 .o_forward_b(forward_b_sel));
  
  ex_mem flip_flop_EM(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_alu_dataE(alu_dataE),
	 .i_rs2_dataE(data_forward_b),
	 .i_rd_addrE(rd_addrE),
	 .i_pc_fourE(pc_fourE),
    .o_alu_dataM(alu_dataM),
	 .o_rs2_dataM(rs2_dataM),
	 .o_rd_addrM(rd_addrM),
	 .o_pc_fourM(pc_fourM)
  );

  //MEM stage
  lsu dmem(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_lsu_addr(alu_dataM),
	 .i_st_data(rs2_dataM),
    .i_lsu_wren(i_lsu_wrenM),
    .i_io_sw(i_io_sw),
    .o_ld_data(ld_dataM),
	 .o_io_ledr(o_io_ledr),
	 .o_io_ledg(o_io_ledg)
  );
  


  mem_wb flip_flop_mw(
    .i_clk(i_clk),
	 .i_rst_n(i_rst_n),
    .i_ld_dataM(ld_dataM),
	 .i_alu_dataM(alu_dataM),
	 .i_rd_addrM(rd_addrM),
	 .i_pc_fourM(pc_fourM),
    .o_ld_dataW(ld_dataW),
	 .o_alu_dataW(alu_dataW),
	 .o_rd_addrW(rd_addrW),
	 .o_pc_fourW(pc_fourW)
  );
  
  //WB stage
  mux3to1 mux3(
    .i_a(alu_dataW),
	 .i_b(ld_dataW),
	 .i_c(pc_fourW),
	 .i_sel(i_wb_selW),
	 .o_y(rd_dataW)
  );
  //Hazard
  hazard_unit hazard(
    .Memread(i_lsu_rdenE),
    .inst(instD),
    .Rd(rd_addrE),
    .stall(stall)
  );
  assign o_inst  = instD;
  assign o_stall = stall;
  assign o_flush = flush;
endmodule