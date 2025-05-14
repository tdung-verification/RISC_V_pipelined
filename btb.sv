module btb (
  input  logic i_clk, i_rst_n,
  input  logic [9:0] i_addr_rd_table,
  input  logic [9:0] i_addr_wr_table,
  input  logic [19:0] i_tag,
  input  logic [31:0] i_predicted_pc,
  input  logic i_wren,
  output logic [19:0] o_tag,
  output logic [31:0] o_predicted_pc,
  output logic o_valid
);
  integer i;
  logic [31:0] predicted_PC_MEM [1023:0];
  logic [19:0] tag_MEM          [1023:0];
  logic        valid_MEM        [1023:0];
//Write
  always_ff @( posedge i_clk) begin
    if(!i_rst_n) begin
      for (i = 0; i < 1024; i = i + 1) begin
        valid_MEM[i] = 1'b0;
        tag_MEM[i]   <= 20'd0;
        predicted_PC_MEM[i] <= 32'd0;
      end
	 end
    else if(i_wren) begin
	   tag_MEM[i_addr_wr_table]          <= i_tag;
		predicted_PC_MEM[i_addr_wr_table] <= i_predicted_pc;
		valid_MEM[i_addr_wr_table]        <= 1'b1;
	 end
  end
// read
  assign o_tag          = tag_MEM[i_addr_rd_table]  ;
  assign o_valid        = valid_MEM[i_addr_rd_table];
  assign o_predicted_pc = predicted_PC_MEM[i_addr_rd_table];
endmodule