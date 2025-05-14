module alu (
  input  logic [31:0] i_operand_a, i_operand_b,
  input  logic  [3:0] i_alu_op,
  output logic [31:0] o_alu_data
);

  localparam ALU_ADD  = 4'b0000;
  localparam ALU_SUB  = 4'b0001;
  localparam ALU_SLL  = 4'b0010;
  localparam ALU_SLT  = 4'b0011;
  localparam ALU_SLTU = 4'b0100;
  localparam ALU_XOR  = 4'b0101;
  localparam ALU_SRL  = 4'b0110;
  localparam ALU_SRA  = 4'b0111;
  localparam ALU_OR   = 4'b1000;
  localparam ALU_AND  = 4'b1001;
  localparam ALU_PASS = 4'b1010;

  logic [31:0] sub_result;
  logic borrow, overflow;
  //tinh toan phep tru
  assign {borrow, sub_result} = {1'b0,i_operand_a} + ~{1'b0,i_operand_b} + 33'b1;
  //kiem tra tran so
  assign overflow = (i_operand_a[31] & ~i_operand_b[31] & ~sub_result[31]) | (~i_operand_a[31] & i_operand_b[31] & sub_result[31]);

  always_comb begin
    case(i_alu_op)
	   ALU_ADD: o_alu_data = i_operand_a + i_operand_b;                 //ADD
		ALU_SUB: o_alu_data = sub_result;                                //SUB
		ALU_SLL: begin//SLL
		  case(i_operand_b[4:0])
		    5'd0: o_alu_data = i_operand_a;
			 5'd1: o_alu_data = {i_operand_a[30:0],1'b0};
			 5'd2: o_alu_data = {i_operand_a[29:0],2'b0};
			 5'd3: o_alu_data = {i_operand_a[28:0],3'b0};
			 5'd4: o_alu_data = {i_operand_a[27:0],4'b0};
			 5'd5: o_alu_data = {i_operand_a[26:0],5'b0};
			 5'd6: o_alu_data = {i_operand_a[25:0],6'b0};
			 5'd7: o_alu_data = {i_operand_a[24:0],7'b0};
			 5'd8: o_alu_data = {i_operand_a[23:0],8'b0};
			 5'd9: o_alu_data = {i_operand_a[22:0],9'b0};
			 5'd10: o_alu_data = {i_operand_a[21:0],10'b0};
			 5'd11: o_alu_data = {i_operand_a[20:0],11'b0};
			 5'd12: o_alu_data = {i_operand_a[19:0],12'b0};
			 5'd13: o_alu_data = {i_operand_a[18:0],13'b0};
			 5'd14: o_alu_data = {i_operand_a[17:0],14'b0};
			 5'd15: o_alu_data = {i_operand_a[16:0],15'b0};
			 5'd16: o_alu_data = {i_operand_a[15:0],16'b0};
			 5'd17: o_alu_data = {i_operand_a[14:0],17'b0};
			 5'd18: o_alu_data = {i_operand_a[13:0],18'b0};
			 5'd19: o_alu_data = {i_operand_a[12:0],19'b0};
			 5'd20: o_alu_data = {i_operand_a[11:0],20'b0};
			 5'd21: o_alu_data = {i_operand_a[10:0],21'b0};
			 5'd22: o_alu_data = {i_operand_a[9:0],22'b0};
			 5'd23: o_alu_data = {i_operand_a[8:0],23'b0};
			 5'd24: o_alu_data = {i_operand_a[7:0],24'b0};
			 5'd25: o_alu_data = {i_operand_a[6:0],25'b0};
			 5'd26: o_alu_data = {i_operand_a[5:0],26'b0};
			 5'd27: o_alu_data = {i_operand_a[4:0],27'b0};
			 5'd28: o_alu_data = {i_operand_a[3:0],28'b0};
			 5'd29: o_alu_data = {i_operand_a[2:0],29'b0};
			 5'd30: o_alu_data = {i_operand_a[1:0],30'b0};
			 5'd31: o_alu_data = {i_operand_a[0],31'b0};
			 default: o_alu_data =  32'b0;
		  endcase
		  end
		ALU_SLT: o_alu_data = {30'b0, sub_result[31] ^ overflow};
		ALU_SLTU: o_alu_data = {30'b0, borrow};
		ALU_XOR: o_alu_data = i_operand_a ^ i_operand_b;                 //XOR
		ALU_SRL: begin//SRL
		  case(i_operand_b[4:0])
		    5'd0: o_alu_data = i_operand_a;
			 5'd1: o_alu_data = {1'b0,i_operand_a[31:1]};
			 5'd2: o_alu_data = {2'b0,i_operand_a[31:2]};
			 5'd3: o_alu_data = {3'b0,i_operand_a[31:3]};
			 5'd4: o_alu_data = {4'b0,i_operand_a[31:4]};
			 5'd5: o_alu_data = {5'b0,i_operand_a[31:5]};
			 5'd6: o_alu_data = {6'b0,i_operand_a[31:6]};
			 5'd7: o_alu_data = {7'b0,i_operand_a[31:7]};
			 5'd8: o_alu_data = {8'b0,i_operand_a[31:8]};
			 5'd9: o_alu_data = {9'b0,i_operand_a[31:9]};
			 5'd10: o_alu_data = {10'b0,i_operand_a[31:10]};
			 5'd11: o_alu_data = {11'b0,i_operand_a[31:11]};
			 5'd12: o_alu_data = {12'b0,i_operand_a[31:12]};
			 5'd13: o_alu_data = {13'b0,i_operand_a[31:13]};
			 5'd14: o_alu_data = {14'b0,i_operand_a[31:14]};
			 5'd15: o_alu_data = {15'b0,i_operand_a[31:15]};
			 5'd16: o_alu_data = {16'b0,i_operand_a[31:16]};
			 5'd17: o_alu_data = {17'b0,i_operand_a[31:17]};
			 5'd18: o_alu_data = {18'b0,i_operand_a[31:18]};
			 5'd19: o_alu_data = {19'b0,i_operand_a[31:19]};
			 5'd20: o_alu_data = {20'b0,i_operand_a[31:20]};
			 5'd21: o_alu_data = {21'b0,i_operand_a[31:21]};
			 5'd22: o_alu_data = {22'b0,i_operand_a[31:22]};
			 5'd23: o_alu_data = {23'b0,i_operand_a[31:23]};
			 5'd24: o_alu_data = {24'b0,i_operand_a[31:24]};
			 5'd25: o_alu_data = {25'b0,i_operand_a[31:25]};
			 5'd26: o_alu_data = {26'b0,i_operand_a[31:26]};
			 5'd27: o_alu_data = {27'b0,i_operand_a[31:27]};
			 5'd28: o_alu_data = {28'b0,i_operand_a[31:28]};
			 5'd29: o_alu_data = {29'b0,i_operand_a[31:29]};
			 5'd30: o_alu_data = {30'b0,i_operand_a[31:30]};
			 5'd31: o_alu_data = {31'b0,i_operand_a[31]};
			 default: o_alu_data =  32'b0;
		  endcase
		  end
		ALU_SRA: begin//SRA
		  case(i_operand_b[4:0])
		    5'd0: o_alu_data = i_operand_a;
			 5'd1: o_alu_data = {i_operand_a[31],i_operand_a[31:1]};
			 5'd2: o_alu_data = {{2{i_operand_a[31]}},i_operand_a[31:2]};
			 5'd3: o_alu_data = {{3{i_operand_a[31]}},i_operand_a[31:3]};
			 5'd4: o_alu_data = {{4{i_operand_a[31]}},i_operand_a[31:4]};
			 5'd5: o_alu_data = {{5{i_operand_a[31]}},i_operand_a[31:5]};
			 5'd6: o_alu_data = {{6{i_operand_a[31]}},i_operand_a[31:6]};
			 5'd7: o_alu_data = {{7{i_operand_a[31]}},i_operand_a[31:7]};
			 5'd8: o_alu_data = {{8{i_operand_a[31]}},i_operand_a[31:8]};
			 5'd9: o_alu_data = {{9{i_operand_a[31]}},i_operand_a[31:9]};
			 5'd10: o_alu_data = {{10{i_operand_a[31]}},i_operand_a[31:10]};
			 5'd11: o_alu_data = {{11{i_operand_a[31]}},i_operand_a[31:11]};
			 5'd12: o_alu_data = {{12{i_operand_a[31]}},i_operand_a[31:12]};
			 5'd13: o_alu_data = {{13{i_operand_a[31]}},i_operand_a[31:13]};
			 5'd14: o_alu_data = {{14{i_operand_a[31]}},i_operand_a[31:14]};
			 5'd15: o_alu_data = {{15{i_operand_a[31]}},i_operand_a[31:15]};
			 5'd16: o_alu_data = {{16{i_operand_a[31]}},i_operand_a[31:16]};
			 5'd17: o_alu_data = {{17{i_operand_a[31]}},i_operand_a[31:17]};
			 5'd18: o_alu_data = {{18{i_operand_a[31]}},i_operand_a[31:18]};
			 5'd19: o_alu_data = {{19{i_operand_a[31]}},i_operand_a[31:19]};
			 5'd20: o_alu_data = {{20{i_operand_a[31]}},i_operand_a[31:20]};
			 5'd21: o_alu_data = {{21{i_operand_a[31]}},i_operand_a[31:21]};
			 5'd22: o_alu_data = {{22{i_operand_a[31]}},i_operand_a[31:22]};
			 5'd23: o_alu_data = {{23{i_operand_a[31]}},i_operand_a[31:23]};
			 5'd24: o_alu_data = {{24{i_operand_a[31]}},i_operand_a[31:24]};
			 5'd25: o_alu_data = {{25{i_operand_a[31]}},i_operand_a[31:25]};
			 5'd26: o_alu_data = {{26{i_operand_a[31]}},i_operand_a[31:26]};
			 5'd27: o_alu_data = {{27{i_operand_a[31]}},i_operand_a[31:27]};
			 5'd28: o_alu_data = {{28{i_operand_a[31]}},i_operand_a[31:28]};
			 5'd29: o_alu_data = {{29{i_operand_a[31]}},i_operand_a[31:29]};
			 5'd30: o_alu_data = {{30{i_operand_a[31]}},i_operand_a[31:30]};
			 5'd31: o_alu_data = {{31{i_operand_a[31]}},i_operand_a[31]};
			 default: o_alu_data =  32'b0;
		  endcase
		end
		ALU_OR: o_alu_data = i_operand_a | i_operand_b;                 //OR
		ALU_AND: o_alu_data = i_operand_a & i_operand_b;                 //AND
		ALU_PASS: o_alu_data = i_operand_b;
		default: o_alu_data = 32'b0;
	 endcase
  end
endmodule