`timescale 1ns/1ps

module tb_pipelined;

  // Clock & reset
  logic clk;
  logic rst_n;

  // Input switch
  logic [31:0] io_sw;

  // Outputs
  logic [31:0] io_ledr, io_ledg;
  logic o_insn_vld, o_mispred, o_ctrl;
  logic [31:0] o_pc_debug;
  logic [31:0] nextpcF, instF;
  logic [31:0] instD, pcD;
  logic [31:0] rs1_dataD, rs2_dataD, immD;
  logic [31:0] rs1_dataE, rs2_dataE, alu_dataE, immE;
  logic [4:0] rs1_addrE, rs2_addrE, rd_addrE, rd_addrM;
  logic [31:0] alu_dataM, rs2_dataM;
  logic [4:0] rd_addrW;
  logic [31:0] pcE, pc_fourE;
  logic [31:0] operand_a, operand_b;
  logic [3:0] alu_op;
  logic [1:0] forward_a_sel, forward_b_sel;
  logic [2:0] funct3E;
  logic funct7E, opcode5E, branch_takenE, branch_takenM;
  logic [31:0] rd_dataW, ld_dataW, un_ld_dataM, un_ld_dataW;
  logic rd_wrenM, rd_wrenW, lsu_rdenM, lsu_rdenW, lsu_wrenM;
  logic jalE, jalM, branchE, opb_selE, alu_decE, branchM;
  logic [1:0] opa_selE;
  logic stall, flush;
  logic [31:0] data_forward_a, data_forward_b;
  logic [31:0] pcF, pc_fourF, pc_fourD, pc_fourM, pc_fourW;

  // Instantiate DUT
  pipelined dut (
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_io_sw(io_sw),
    .o_io_ledr(io_ledr),
    .o_io_ledg(io_ledg),
    .o_insn_vld(o_insn_vld),
    .o_mispred(o_mispred),
    .o_ctrl(o_ctrl),
    .o_pc_debug(o_pc_debug),
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
    .funct7E(funct7E), .opcode5E(opcode5E), .branch_takenE(branch_takenE), .branch_takenM(branch_takenM),
    .rd_dataW(rd_dataW), .ld_dataW(ld_dataW),
    .un_ld_dataM(un_ld_dataM), .un_ld_dataW(un_ld_dataW),
    .rd_wrenM(rd_wrenM), .rd_wrenW(rd_wrenW),
    .lsu_rdenM(lsu_rdenM), .lsu_rdenW(lsu_rdenW), .lsu_wrenM(lsu_wrenM),
    .jalE(jalE), .jalM(jalM), .branchE(branchE),
    .opb_selE(opb_selE), .alu_decE(alu_decE), .opa_selE(opa_selE),
    .stall(stall), .flush(flush),
    .data_forward_a(data_forward_a), .data_forward_b(data_forward_b),
    .pcF(pcF), .pc_fourF(pc_fourF), .pc_fourD(pc_fourD), .pc_fourM(pc_fourM), .pc_fourW(pc_fourW),
    .branchM(branchM)
  );

  // Clock generation: 100 MHz
  always #5 clk = ~clk;

  // Initial stimulus
  initial begin
    // Dump waveform
    $dumpfile("tb_pipelined.vcd");
    $dumpvars(0, tb_pipelined);

    // Initialize
    clk = 0;
    rst_n = 0;
    io_sw = 32'h00000000;

    // Hold reset for 3 cycles
    #20;
    rst_n = 1;

    // Apply switch values
    #20 io_sw = 32'h02345678;


    // Run for a while then finish
    #500;
    $finish;
  end

  // Monitor important signals
  always @(posedge clk) begin
    if (rst_n) begin
      $display("[%0t ns] PC=%h, instF=%h, insn_vld=%b, mispred=%b, ctrl=%b, stall=%b, flush=%b",
        $time, o_pc_debug, instF, o_insn_vld, o_mispred, o_ctrl, stall, flush);
    end
  end

endmodule
