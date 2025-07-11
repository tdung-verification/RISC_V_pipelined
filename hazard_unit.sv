module hazard_unit(
  input  logic Memread,
  input  logic [4:0] Rs1, Rs2,
  input  logic [4:0] Rd,
  output logic stall
);
  always_comb begin
    if(Memread == 1'b1 && ((Rd == Rs1) || (Rd == Rs2)))
	   stall = 1'b1;
    else stall = 1'b0;
  end
endmodule