/// 1. RTL modelling

// Normally the module name and the file name are the same
module comp1b(
    input wire a,
    input wire b,
    output wire c
);
wire e,f;
assign e = ~a & ~b;
assign f = a & b;
assign c = e | f;

// can also use
// assign z = (~x & ~y) | (x & y);



endmodule



/*/// 2. Gate Level Modeling

module comp1b(
    input a,
    input b,
    output c
);

wire aab, na, nb, naanb; // a shows AND, n shows NOT


not N1(na, a);
not N2(nb, b);
and A1(aab, a, b);
and A2(naanb, na, nb);
or O1(c, aab, naanb);


endmodule
*/


/*// 3. Behavioural Modeling
module mynotgate(
    input wire a,
    output reg nota
);

always @(*) begin // always is used normally in sequential ccts, state machines
    if(a) nota = 0; // if(a == postive), then set nota == 0
    else nota = 1; // else set nota to 1
  
end

endmodule
*/