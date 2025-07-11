/*module local_prediction(
  input  logic i_clk, i_rst_n, i_stall
  input  logic [7:0] i_PCF, i_PCE,
  input  logic       i_enable,
  input  logic branch_taken,
  output logic o_predict_taken
);

  logic [3:0] LHR_mem [255:0];
  logic [3:0] LHR_memD [255:0];
  logic [3:0] LHR_memE [255:0];
  logic [1:0] PHT_mem [15:0];
  logic [3:0] addr_PHT_mem;
  logic [1:0] data_PHT_mem;
//read
  assign addr_PHT_mem = LHR_mem[i_PCF];
  assign data_PHT_mem = PHT_mem[addr_PHT_mem];
  assign o_predict_taken = data_PHT_mem[1];
  
//write
  always_ff @(negedge i_clk) begin
    if(!i_rst_n) begin
		 for (int i = 0; i < 256; i++) begin
          LHR_mem[i] <= 4'b00;
       end
		 for (int i = 0; i < 16; i++) begin
          PHT_mem[i] <= 2'b01;
       end
	 end
	 else begin
	   LHR_memD <= LHR_mem[i_PCF] ;
		LHR_memE <= LHR_memD;
	   if (i_enable & ~i_stall) begin
		  LHR_memE <= {LHR_mem[2:0],branch_taken};
		  
		end
	 end
  end
  assign value_counter = PHT_mem[LHR_memE];
  saturated_adder(
    .val_i(value_counter),
    .taken(branch_taken),   
    .val_o(next_value_counter) 
endmodule
*/