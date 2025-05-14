module if_id (
  input  logic i_clk, i_rst_n, i_stall, i_flush,
  input  logic [31:0] i_pcF, i_instF, i_pc_fourF,
  output logic [31:0] o_pcD, o_instD, o_pc_fourD
);
  always_ff @(posedge i_clk) begin
    if (~i_rst_n || i_flush) begin
	   o_pcD       <= 32'b0;
		o_instD    <= 32'b0;
		o_pc_fourD  <= 32'b0;
	 end
	 else if (i_stall == 1'b0) begin
	   o_pcD      <= i_pcF;
		o_instD    <= i_instF;
		o_pc_fourD <= i_pc_fourF;
	 end
  end
endmodule