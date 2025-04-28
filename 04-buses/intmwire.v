module intmwire(
  input wire a,
  input wire b,
  input wire c,
  input wire p,
  input wire q
);

  wire intmwire;

  assign intmwire = a & b;
  assign p = intmwire | c;
  assign q = intmwire & c;

endmodule

