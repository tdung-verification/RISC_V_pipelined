`timescale 1ns/1ps

module tb_pipelined;

  // Inputs
  logic        i_clk;
  logic        i_rst_n;
  logic [31:0] i_io_sw;

  // Outputs
  logic [31:0] o_io_ledr, o_io_ledg;
  logic [31:0] nextpcF, instF;
  logic [31:0] instD, pcD;
  logic [31:0] rs1_dataD, rs2_dataD, immD;
  logic [31:0] rs1_dataE, rs2_dataE, alu_dataE, immE;
  logic [4:0]  rs1_addrE, rs2_addrE, rd_addrE, rd_addrM;
  logic [31:0] alu_dataM, rs2_dataM;
  logic [4:0]  rd_addrW;
  logic [31:0] pcE, pc_fourE;
  logic [31:0] operand_a, operand_b;
  logic [3:0]  alu_op;
  logic [1:0]  forward_a_sel, forward_b_sel;
  logic [2:0]  funct3E;
  logic        funct7E, opcode5E, branch_takenE;
  logic [31:0] rd_dataW, ld_dataW, alu_dataW;
  logic        rd_wrenM, rd_wrenW, lsu_rdenE, lsu_wrenM;
  logic        jalE, branchE, opb_selE, alu_decE;
  logic [1:0]  opa_selE, wb_selW;
  logic        stall, flush;
  logic [31:0] data_forward_a, data_forward_b;
  logic [31:0]  pcF, pc_fourF, pc_fourD, pc_fourM, pc_fourW;
  // Instantiate the DUT
  pipelined dut (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_io_sw(i_io_sw),
    .o_io_ledr(o_io_ledr),
    .o_io_ledg(o_io_ledg),
    .nextpcF(nextpcF), .instF(instF),
    .instD(instD), .pcD(pcD),
    .rs1_dataD(rs1_dataD), .rs2_dataD(rs2_dataD), .immD(immD),
    .rs1_dataE(rs1_dataE), .rs2_dataE(rs2_dataE), .alu_dataE(alu_dataE), .immE(immE),
    .rs1_addrE(rs1_addrE), .rs2_addrE(rs2_addrE), .rd_addrE(rd_addrE), .rd_addrM(rd_addrM),
    .alu_dataM(alu_dataM), .rs2_dataM(rs2_dataM),
    .rd_addrW(rd_addrW),
    .pcE(pcE), .pc_fourE(pc_fourE),
    .operand_a(operand_a), .operand_b(operand_b),
    .alu_op(alu_op),
    .forward_a_sel(forward_a_sel), .forward_b_sel(forward_b_sel),
    .funct3E(funct3E),
    .funct7E(funct7E), .opcode5E(opcode5E), .branch_takenE(branch_takenE),
    .rd_dataW(rd_dataW), .ld_dataW(ld_dataW), .alu_dataW(alu_dataW),
    .rd_wrenM(rd_wrenM), .rd_wrenW(rd_wrenW),
    .lsu_rdenE(lsu_rdenE), .lsu_wrenM(lsu_wrenM),
    .jalE(jalE), .branchE(branchE),
    .opb_selE(opb_selE), .alu_decE(alu_decE),
    .opa_selE(opa_selE), .wb_selW(wb_selW),
    .stall(stall), .flush(flush),
    .data_forward_a(data_forward_a),
	 .data_forward_b(data_forward_b),
	 .pcF(pcF),
	 .pc_fourF(pc_fourF),
	 .pc_fourD(pc_fourD),
	 .pc_fourM(pc_fourM),
	 .pc_fourW(pc_fourW)
  );

  // Clock generation
  always #5 i_clk = ~i_clk;

  // Initial block
  initial begin
    $display("=== Starting pipelined testbench ===");

    // Initial values
    i_clk = 0;
    i_rst_n = 0;
    i_io_sw = 32'h00000000;

    // Apply reset
    #20;
    i_rst_n = 1;

    // Set switch value (test input)
    #10 i_io_sw = 32'hA5A5A5A5;


    // Observe further
    #1000;

    // End simulation
    $display("=== Ending simulation ===");
    $finish;
  end

endmodule
