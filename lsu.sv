module lsu(
  input  logic i_clk, i_rst_n,
  input  logic [31:0] i_lsu_addr, i_st_data,
  input  logic i_lsu_wren,
  input  logic [31:0] i_io_sw,
  output logic [31:0] o_ld_data, o_io_ledr, o_io_ledg
);
  logic [31:0] ledr, ledg, switch;
  logic [31:0] dram [8191:0];
  
  //input combination
  assign switch = i_io_sw;
  
  //load
  always_comb begin
    case(i_lsu_addr[15:12])
      4'd2, 4'd3: o_ld_data = dram[{i_lsu_addr[15:12] == 4'd2 ? 4'b0 : 4'b1, i_lsu_addr[11:0]}];
      4'd7:
		  case(i_lsu_addr[11:8])
		    4'd0:
            case(i_lsu_addr[7:4])
              4'd0: o_ld_data = ledr;
              4'd1: o_ld_data = ledg;
              default: o_ld_data = 32'b0;
            endcase
		    4'd8: o_ld_data = switch;
			 default: o_ld_data = 32'b0;
		  endcase
      default: o_ld_data = 32'b0;
    endcase
  end

  
  //store
  always_ff @(posedge i_clk ) begin
    if (!i_rst_n) begin
      ledr <= 32'b0;
      ledg <= 32'b0;
    end else if (i_lsu_wren) begin
      case(i_lsu_addr[15:12])
        4'd2: dram[{4'b0,i_lsu_addr[11:0]}] <= i_st_data;
        4'd3: dram[{4'b1,i_lsu_addr[11:0]}] <= i_st_data;
        4'd7:
		    case(i_lsu_addr[11:8])
			 4'd0:
            case(i_lsu_addr[7:4])
              4'd0: ledr <= i_st_data;
              4'd1: ledg <= i_st_data;
            endcase
		    endcase
      endcase
    end
  end

  
  //output combination
  assign o_io_ledr = ledr;
  assign o_io_ledg = ledg;

endmodule