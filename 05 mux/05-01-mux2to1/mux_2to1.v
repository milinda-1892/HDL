// 2:1 Mux with 1-bit inputs and output
// input A0(1bit), B0(1bit), Se
// output y

module mux_2to1(
  input wire a ,//
  input wire b,// 1-bit input A0
  input wire se,// select
  input wire en,// 1/
  output wire y // Output (1 bit)
);

  // Mux logic using conditional operator
 //ssign y = se ?  a : b; // If Se is high, output B0; otherwise output A0
  assign y = en ? (se ? a : b) : 1'bz; // If en is high, output A0 or B0; otherwise high impedance

  endmodule
  //Note
