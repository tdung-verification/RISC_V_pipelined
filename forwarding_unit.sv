module forwarding_unit(
  input  logic [4:0] i_rs1_addrE, i_rs2_addrE,
  input  logic [4:0] i_rd_addrM, i_rd_addrW,
  input  logic        i_rd_wrenM, i_rd_wrenW,
  output logic [1:0] o_forward_a, o_forward_b
);
  always_comb begin
  // forward a
   if(i_rd_wrenM && (i_rd_addrM != 5'b0) && (i_rd_addrM == i_rs1_addrE))
	  o_forward_a = 2'b01;
	else if (i_rd_wrenW && (i_rd_addrW != 5'b0) && (i_rd_addrW == i_rs1_addrE))
	  o_forward_a = 2'b10;
	else o_forward_a = 2'b00;
  // forward b
   if(i_rd_wrenM && (i_rd_addrM != 5'b0) && (i_rd_addrM == i_rs2_addrE))
	  o_forward_b = 2'b01;
	else if (i_rd_wrenW && (i_rd_addrW != 5'b0) && (i_rd_addrW == i_rs2_addrE))
	  o_forward_b = 2'b10;
	else o_forward_b = 2'b00;
  end
endmodule