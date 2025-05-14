module ex_mem(
  input  logic i_clk, i_rst_n,
  input  logic [31:0] i_alu_dataE, i_rs2_dataE, i_pc_fourE,
  input  logic [4:0]  i_rd_addrE,
  output logic [31:0] o_alu_dataM, o_rs2_dataM, o_pc_fourM,
  output logic [4:0]  o_rd_addrM
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n) begin
	   o_alu_dataM <= 32'b0;
		o_rs2_dataM <= 32'b0;
		o_rd_addrM  <= 5'b0 ;
		o_pc_fourM  <= 32'b0;
	 end
	 else begin
	   o_alu_dataM <= i_alu_dataE;
		o_rs2_dataM <= i_rs2_dataE;
		o_rd_addrM  <= i_rd_addrE ;
		o_pc_fourM  <= i_pc_fourE ;
	 end
  end
endmodule