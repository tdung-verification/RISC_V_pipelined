module pipelined(
  input  logic        i_clk, i_rst_n,
  input  logic [31:0] i_io_sw,
  output logic [31:0] o_io_ledr, o_io_ledg,
  output logic o_insn_vld, o_mispred, o_ctrl,
  output logic [31:0] o_pc_debug,
  output logic [31:0] nextpcF,instF,
  output logic [31:0] instD, pcD,
  output logic [31:0] rs1_dataD, rs2_dataD, immD,
  output logic [31:0] rs1_dataE, rs2_dataE, alu_dataE, immE,
  output logic [4:0]  rs1_addrE, rs2_addrE, rd_addrE, rd_addrM,
  output logic [31:0] alu_dataM, rs2_dataM,
  output logic [4:0]  rd_addrW,
  output logic [31:0] pcE, pc_fourE,
  output logic [31:0] operand_a, operand_b,
  output logic [3:0] alu_op,
  output logic [1:0]  forward_a_sel, forward_b_sel,
  output logic [2:0]  funct3E,
  output logic       funct7E, opcode5E, branch_takenE, branch_takenM,
  output logic [31:0] rd_dataW, ld_dataW, un_ld_dataM, un_ld_dataW,
  output logic [31:0] data_forward_a, data_forward_b,
  output logic [31:0]  pcF, pc_fourF, pc_fourD, pc_fourM, pc_fourW,
  
  output logic [1:0] opa_selE,
  output logic rd_wrenM, rd_wrenW, lsu_rdenM, lsu_rdenW, lsu_wrenM, jalE, jalM, branchE, opb_selE, alu_decE, branchM,
  output logic stall, flush
);

  /*logic o_insn_vld, o_mispred, o_ctrl;
  logic [31:0] o_pc_debug;
  
  logic [31:0] nextpcF,instF;
  logic [31:0] instD, pcD;
  logic [31:0] rs1_dataD, rs2_dataD, immD;
  logic [31:0] rs1_dataE, rs2_dataE, alu_dataE, immE;
  logic [4:0]  rs1_addrE, rs2_addrE, rd_addrE, rd_addrM;
  logic [31:0] alu_dataM, rs2_dataM;
  logic [4:0]  rd_addrW;
  logic [31:0] pcE, pc_fourE;
  logic [31:0] operand_a, operand_b;
  logic [3:0] alu_op;
  logic [1:0]  forward_a_sel, forward_b_sel;
  logic [2:0]  funct3E;
  logic       funct7E, opcode5E, branch_takenE;
  logic [31:0] rd_dataW, ld_dataW, un_ld_dataM, un_ld_dataW;
  logic [31:0] data_forward_a, data_forward_b;
  logic [31:0]  pcF, pc_fourF, pc_fourD, pc_fourM, pc_fourW;
  
  logic [1:0] opa_selE;
  logic rd_wrenM, rd_wrenW, lsu_rdenM, lsu_rdenW, lsu_wrenM, jalE, jalM, branchE, opb_selE, alu_decE, branchD;
  logic stall, flush;
  */
  logic [31:0] inst;
  
  datapath datapath_riscv/*(
    .i_clk(i_clk), 
	 .i_rst_n(i_rst_n),
	 .i_rd_wrenM(rd_wrenM),
    .i_rd_wrenW(rd_wrenW),
	 .i_lsu_rdenM(lsu_rdenM),
	 .i_lsu_wrenM(lsu_wrenM), 
	 .i_lsu_rdenW(lsu_rdenW), 
	 .i_jalE(jalE), 
	 .i_jalM(jalM),
	 .i_branchE(branchE),
	 .i_opb_selE(opb_selE),
    .i_alu_decE(alu_decE), 
	 .i_opa_selE(opa_selE),
    .i_io_sw(i_io_sw),
    .o_io_ledr(o_io_ledr),
	 .o_io_ledg(o_io_ledg),
	 .o_inst(inst),
	 .o_insn_vld(o_insn_vld),
	 .o_mispred(o_mispred),
	 .o_pc_debug(o_pc_debug),
	 .o_stall(stall),
	 .o_flush(flush));
  */(
    .i_clk(i_clk), 
	 .i_rst_n(i_rst_n),
	 .i_rd_wrenM(rd_wrenM),
    .i_rd_wrenW(rd_wrenW),
	 .i_lsu_rdenM(lsu_rdenM),
	 .i_lsu_wrenM(lsu_wrenM), 
	 .i_lsu_rdenW(lsu_rdenW), 
	 .i_jalE(jalE), 
	 .i_jalM(jalM),
	 .i_branchE(branchE),
	 .i_branchM(branchM),
	 .i_opb_selE(opb_selE),
    .i_alu_decE(alu_decE), 
	 .i_opa_selE(opa_selE),
    .i_io_sw(i_io_sw),
    .o_io_ledr(o_io_ledr),
	 .o_io_ledg(o_io_ledg),
	 .o_inst(inst),
	 .o_insn_vld(o_insn_vld),
	 .o_mispred(o_mispred),
	 .o_pc_debug(o_pc_debug),
	 .o_stall(stall),
	 .o_flush(flush),
    .nextpcF(nextpcF),
	 .instF(instF),
    .instD(instD), 
	 .pcD(pcD),
    .rs1_dataD(rs1_dataD), 
	 .rs2_dataD(rs2_dataD), 
	 .immD(immD),
    .rs1_dataE(rs1_dataE), 
	 .rs2_dataE(rs2_dataE), 
	 .rs1_addrE(rs1_addrE), 
	 .rs2_addrE(rs2_addrE), 
	 .rd_addrE(rd_addrE), 
	 .alu_dataE(alu_dataE), 
	 .immE(immE),
	 .rd_addrM(rd_addrM), 
	 .alu_dataM(alu_dataM),
	 .un_ld_dataM(un_ld_dataM),
	 .un_ld_dataW(un_ld_dataW),
	 .rs2_dataM(rs2_dataM), 
    .pcE(pcE),
	 .pc_fourE(pc_fourE),
    .forward_a_sel(forward_a_sel),
	 .forward_b_sel(forward_b_sel), 
    .alu_op(alu_op),
	 .operand_a(operand_a),
	 .operand_b(operand_b),
    .funct3E(funct3E),
    .funct7E(funct7E), 
	 .opcode5E(opcode5E),
	 .branch_takenE(branch_takenE),
	 .branch_takenM(branch_takenM),
    .rd_dataW(rd_dataW),
	 .rd_addrW(rd_addrW),
	 .ld_dataW(ld_dataW),
	 .data_forward_a(data_forward_a),
	 .data_forward_b(data_forward_b),
	 .pcF(pcF),
	 .pc_fourF(pc_fourF),
	 .pc_fourD(pc_fourD),
	 .pc_fourM(pc_fourM),
	 .pc_fourW(pc_fourW));

  control control_risv(
    .i_clk(i_clk), 
	 .i_rst_n(i_rst_n), 
	 .i_stall(stall),
	 .i_flush(flush),
    .i_inst(inst),
	 .o_rd_wrenM(rd_wrenM),
    .o_rd_wrenW(rd_wrenW),
    .o_lsu_rdenM(lsu_rdenM),
	 .o_lsu_wrenM(lsu_wrenM),
	 .o_lsu_rdenW(lsu_rdenW), 
	 .o_jalE(jalE),
	 .o_jalM(jalM),
	 .o_branchE(branchE),
	 .o_opb_selE(opb_selE),
    .o_alu_decE(alu_decE), 
	 .o_opa_selE(opa_selE),
	 .o_branchM(branchM),
	 .o_ctrl(o_ctrl)
  );
  

endmodule