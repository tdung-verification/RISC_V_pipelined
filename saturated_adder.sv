module saturated_adder(
  input  [1:0] val_i,   // Giá trị hiện tại
  input              taken,   // Nhánh thực sự xảy ra (1) hay không (0)
  output [1:0] val_o    // Giá trị sau cập nhật
);

  wire [1:0] incremented = val_i + 1'b1;
  wire [1:0] decremented = val_i - 1'b1;

  assign val_o = taken ?
                 (val_i == 2'b11 ? val_i : incremented) :  // nếu đã max thì giữ nguyên
                 (val_i == 2'b00 ? val_i : decremented);  // nếu đã min thì giữ nguyên

endmodule