module id_ex(
  input  logic i_clk, i_rst_n, i_flush,
  input  logic [4:0] i_rs1_addrD, i_rs2_addrD,
  input  logic [31:0] i_pcD, i_rs1_dataD, i_rs2_dataD, i_immD, i_pc_fourD,
  input  logic [4:0] i_rd_addrD,
  input  logic [2:0] i_funct3D,
  input  logic i_funct7D, i_opcode5D,
  output logic [4:0] o_rs1_addrE, o_rs2_addrE,
  output logic [31:0] o_pcE, o_rs1_dataE, o_rs2_dataE, o_immE, o_pc_fourE,
  output logic [4:0] o_rd_addrE,
  output logic [2:0] o_funct3E,
  output logic o_funct7E,o_opcode5E
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n || i_flush) begin
      o_pcE <= 32'b0;
		o_rs1_addrE <=  5'b0;
		o_rs2_addrE <=  5'b0;
		o_rs1_dataE <= 32'b0;
		o_rs2_dataE <= 32'b0;
		o_immE      <= 32'b0;
		o_pc_fourE  <= 32'b0;
		o_rd_addrE  <=  5'b0;
      o_funct3E   <=  3'b0;
      o_funct7E   <=  1'b0;
		o_opcode5E  <=  1'b0;
	   end
	 else begin
      o_pcE <= i_pcD;
		o_rs1_addrE <=  i_rs1_addrD;
		o_rs2_addrE <=  i_rs2_addrD;
		o_rs1_dataE <= i_rs1_dataD;
		o_rs2_dataE <= i_rs2_dataD;
		o_immE      <= i_immD;
		o_pc_fourE  <= i_pc_fourD;
		o_rd_addrE  <= i_rd_addrD;
      o_funct3E   <= i_funct3D;
      o_funct7E   <= i_funct7D;
		o_opcode5E  <= i_opcode5D;
	 end
  end
endmodule