
module instmemory(
  input logic [31:0] addr,
  output logic [31:0] rdata
);

  parameter MEM_SIZE = 16;
  logic [31:0] mem [MEM_SIZE-1:0];
  
  always_comb begin : next_pc_ff
    rdata <= mem[addr[31:2]];
  end : next_pc_ff
  
  initial begin
    integer i;
	 for (i=0; i < MEM_SIZE; i++) begin
	   mem[i] = 32'b0;
	 end
	 $readmemh("C:/Users/RISC_V_with_teacher_architecture/mem.dump",mem);
  end

/*  parameter MEM_SIZE = 2048;
  logic [31:0] mem [MEM_SIZE-1:0];
  
  always_comb begin : next_pc_ff
    rdata <= mem[addr[31:2]];
  end : next_pc_ff
  
  initial begin
    integer i;
	 for (i=0; i < MEM_SIZE; i++) begin
	   mem[i] = 32'b0;
	 end
	 $readmemh("C:/Users/TUAN/tailieuhocbk/nam4ki1/RISC_V_with_teacher_architecture/mem.dump",mem);
  end
*/
endmodule: instmemory