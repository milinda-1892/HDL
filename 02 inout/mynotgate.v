/*// 1. RTL modelling

// Normally the module name and the file name are the same
module mynotgate(
    input wire a,
    output wire nota
);

assign nota = ~a;

endmodule(
*/

/*// 2. Gate Level Modeling

module mynotgate(
    input wire a,
    output wire nota
);

not ng1(nota, a);

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