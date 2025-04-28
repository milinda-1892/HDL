//start Module
//Module Represents a circuit

module firstmodule();


//intial block
//(procedural block)
//circuit that runs once at the power on (initial)
initial begin

    //cannot be synthesized
    //output goes to console, file, .......
    $display("Hello World"); // to the console
    $finish; // indicate the end of the simulation
end
endmodule
// End of the module