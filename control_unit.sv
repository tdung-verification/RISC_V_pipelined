module control_unit (
  input  logic [31:0] i_inst,
  output logic o_rd_wren, o_lsu_wren, o_lsu_rden, o_jal, o_branch, o_opb_sel, o_alu_dec,
  output logic [1:0]  o_opa_sel, o_wb_sel
);
  logic [6:0] opcode;
  assign opcode = i_inst[6:0];
  always_comb begin
    case(opcode)
	   7'b0110011: begin //r-type
		  o_opa_sel  = 2'b00;
		  o_opb_sel  = 1'b0 ; 
		  o_alu_dec  = 1'b1 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b00;
		  o_rd_wren  = 1'b1 ;
		  end
	   7'b0010011: begin //I-type
		  o_opa_sel  = 2'b00;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b1 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b00;
		  o_rd_wren  = 1'b1 ;
		  end
	   7'b0000011: begin //load-type
		  o_opa_sel  = 2'b00;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b1 ;
		  o_wb_sel   = 2'b01;
		  o_rd_wren  = 1'b1 ;
		  end
	   7'b0100011: begin //S-type
		  o_opa_sel  = 2'b00;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b1 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b00; //tuy dinh
		  o_rd_wren  = 1'b0 ;
		  end
	   7'b1100011: begin //B-type
		  o_opa_sel  = 2'b01;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b1 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b00; //tuy dinh
		  o_rd_wren  = 1'b0 ;
		  end
	   7'b1101111: begin  //J-type
		  o_opa_sel  = 2'b01;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b1 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b10;
		  o_rd_wren  = 1'b1 ;
		  end
	   7'b0110111: begin  // lui
		  o_opa_sel  = 2'b10;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b00;
		  o_rd_wren  = 1'b1 ;
		  end
	   7'b0010111: begin  // auipc
		  o_opa_sel  = 2'b01;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b00;
		  o_rd_wren  = 1'b1 ;
		  end
	   7'b1100111: begin  // jalr
		  o_opa_sel  = 2'b00;
		  o_opb_sel  = 1'b1 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b10;
		  o_rd_wren  = 1'b1 ;
		  end
		default: begin
		  o_opa_sel  = 2'b00;
		  o_opb_sel  = 1'b0 ;
		  o_alu_dec  = 1'b0 ;
		  o_branch   = 1'b0 ;
        o_jal      = 1'b0 ;
		  o_lsu_wren = 1'b0 ;
		  o_lsu_rden = 1'b0 ;
		  o_wb_sel   = 2'b00;
		  o_rd_wren  = 1'b0 ;
		  end
	 endcase
  end
endmodule