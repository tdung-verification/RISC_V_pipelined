module pipelined_tb;

  // Clock and reset
  logic clk;
  logic rst_n;

  // Input switch
  logic [31:0] i_io_sw;

  // Outputs (many signals, grouped by purpose for readability)
  logic [31:0] o_io_ledr, o_io_ledg;
  logic [31:0] nextpcF, instF;
  logic [31:0] instD, pcD;
  logic [31:0] rs1_dataD, rs2_dataD, immD;
  logic [31:0] rs1_dataE, rs2_dataE, alu_dataE, immE;
  logic [4:0]  rs1_addrE, rs2_addrE, rd_addrE, rd_addrM, rd_addrW;
  logic [31:0] rd_dataM, alu_dataM, rs2_dataM, pc_jumpM;
  logic [31:0] pcE, pc_jumpE, pc_fourE;
  logic [31:0] operand_a, operand_b;
  logic [3:0]  alu_op;
  logic [1:0]  forward_a_sel, forward_b_sel;
  logic [2:0]  funct3E;
  logic        funct7E, opcode5E;
  logic        zeroflagE;
  logic        zeroflagM;
  logic [31:0] rd_dataW, ld_dataW, alu_dataW;
  logic        rd_wrenM, rd_wrenW, lsu_rdenE, lsu_wrenM, lsu_rdenD;
  logic         jalM, branchM, jalr_selM, opa_selE;
  logic [1:0]  alu_decE, opb_selE, wb_selW;
  logic stall, flush;
  logic [31:0] data_forward_a, data_forward_b;
  logic pc_selM;

  // Instantiate DUT
  pipelined dut (
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_io_sw(i_io_sw),
    .o_io_ledr(o_io_ledr),
    .o_io_ledg(o_io_ledg),
    .nextpcF(nextpcF),
    .instF(instF),
    .instD(instD),
    .pcD(pcD),
    .rs1_dataD(rs1_dataD),
    .rs2_dataD(rs2_dataD),
    .immD(immD),
    .rs1_dataE(rs1_dataE),
    .rs2_dataE(rs2_dataE),
    .alu_dataE(alu_dataE),
    .immE(immE),
    .rs1_addrE(rs1_addrE),
    .rs2_addrE(rs2_addrE),
    .rd_addrE(rd_addrE),
    .rd_addrM(rd_addrM),
    .rd_dataM(rd_dataM),
    .alu_dataM(alu_dataM),
    .rs2_dataM(rs2_dataM),
    .pc_jumpM(pc_jumpM),
    .rd_addrW(rd_addrW),
    .pcE(pcE),
    .pc_jumpE(pc_jumpE),
    .pc_fourE(pc_fourE),
    .operand_a(operand_a),
    .operand_b(operand_b),
    .alu_op(alu_op),
    .forward_a_sel(forward_a_sel),
    .forward_b_sel(forward_b_sel),
    .funct3E(funct3E),
    .funct7E(funct7E),
    .opcode5E(opcode5E),
    .zeroflagE(zeroflagE),
    .zeroflagM(zeroflagM),
    .rd_dataW(rd_dataW),
    .ld_dataW(ld_dataW),
    .alu_dataW(alu_dataW),
    .rd_wrenM(rd_wrenM),
    .rd_wrenW(rd_wrenW),
    .lsu_rdenD(lsu_rdenD),
    .lsu_rdenE(lsu_rdenE),
    .lsu_wrenM(lsu_wrenM),
    .stall(stall),
	 .flush(flush),
    .wb_selW(wb_selW),
    .jalM(jalM),
    .branchM(branchM),
	 .jalr_selM(jalr_selM),
    .opa_selE(opa_selE),
    .alu_decE(alu_decE),
    .opb_selE(opb_selE),
	 .data_forward_a(data_forward_a),
	 .data_forward_b(data_forward_b),
	 .pc_selM(pc_selM)
  );

  // Clock generation: 10ns period
  always #5 clk = ~clk;

  initial begin
    // Init signals
    clk = 0;
    rst_n = 0;
    i_io_sw = 32'haBCDEF01;

    // Apply reset
    #20;
    rst_n = 1;
    #2000
	 i_io_sw = 32'h0202_0303;
    // Stimulus: change switches if needed

    // Run simulation
    #5000;

    $finish;
  end

  // Optional: monitor some important signals
  initial begin
    $monitor("[%t] pcF=%h, instF=%h, alu_dataE=%h, rd_dataW=%h", 
             $time, nextpcF, instF, alu_dataE, rd_dataW);
  end

endmodule
