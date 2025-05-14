module mem_wb(
  input  logic i_clk, i_rst_n,
  input  logic [31:0] i_ld_dataM, i_alu_dataM, i_pc_fourM,
  input  logic [4:0] i_rd_addrM,
  output logic [31:0] o_ld_dataW, o_alu_dataW, o_pc_fourW,
  output logic [4:0] o_rd_addrW
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n) begin
	   o_ld_dataW  <= 32'b0;
	   o_alu_dataW <= 32'b0;
	   o_rd_addrW  <= 5'b0;
	   o_pc_fourW  <=	32'b0;
	 end
	 else begin
	   o_ld_dataW  <= i_ld_dataM ;
	   o_alu_dataW <= i_alu_dataM;
	   o_rd_addrW  <= i_rd_addrM ;
	   o_pc_fourW  <= i_pc_fourM;	
	 end
  end
endmodule