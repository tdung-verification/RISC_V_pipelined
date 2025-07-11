module mux4to1(
  input  logic [31:0] i_a,i_b,i_c,i_d,
  input  logic [1:0] i_sel,
  output logic [31:0] o_y
);
  always_comb begin
    case(i_sel)
	   2'b00: o_y = i_a;
		2'b01: o_y = i_b;
		2'b10: o_y = i_c;
		2'b11: o_y = i_d;
	 endcase
  end
endmodule