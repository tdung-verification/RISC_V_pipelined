module program_counter (
  input  logic i_clk, i_rst_n, i_stall,
  input  logic [31:0] i_nextpc,
  output logic [31:0] o_pc
);
  always_ff @(posedge i_clk) begin : pc_ff
    if (~i_rst_n)
	   o_pc <= 32'b0;
	 else if (i_stall == 1'b0)
	   o_pc <= i_nextpc;
  end
endmodule