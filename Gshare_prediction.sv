/*module Gshare_prediction(
  input  logic i_clk, i_rst_n, i_stall,
  input  logic [3:0] i_PCF, i_PCE,
  input  logic       i_enable,
  output logic o_predict_taken
);

  logic [1:0] PHT_mem [15:0];
  logic [3:0] GHR_mem, GHR_memD, GHR_memE ;
  logic [1:0] data_PHT;
  logic PHT_addr_rd, PHT_addr_wr;
//read
  assign PHT_addr_rd = i_PCF ^ GHR_mem;
  assign PHT_addr_wr = i_PCE ^ GHR_memE;
  assign data_PHT = PHT_mem[PHT_addr_rd];
  assign o_predict_taken = data_PHT[1];
//write
  always_ff @(negedge i_clk) begin
    if(!i_rst_n) begin
	    GHR_mem <= 4'b0;
		 for (int i = 0; i < 16; i++) begin
          PHT_mem[i] <= 2'b01;
       end
	 end
	 else begin
	   GHR_memD <= GHR_mem ;
		GHR_memE <= GHR_memD;
	   if (i_enable & ~i_stall) begin
		  GHR_mem <= {GHR_mem[2:0],o_predict_taken};
		end
	 end
  end
endmodule
*/