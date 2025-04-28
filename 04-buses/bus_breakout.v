module busbreakout(
  input wire [3:0] a, // 4-bit input bus
  input wire [3:0] b, // 4-bit input bus
  output wire [5:0] p, // 4-bit output bus
  
);

  assign p = {a[1:0], (a[2] & b[0]), (a[3] | b[1]), b[3:2]};
  
  endmodule // Concatenate the bits from a and b to form p