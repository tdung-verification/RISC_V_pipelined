module hazard_unit(
  input  logic Memread,
  input  logic [31:0] inst,
  input  logic [4:0] Rd,
  output logic stall
);
  always_comb begin
    if(Memread == 1'b1 && ((Rd == inst[19:15]) || (Rd == inst[24:20])))
	   stall = 1'b1;
    else stall = 1'b0;
  end
endmodule