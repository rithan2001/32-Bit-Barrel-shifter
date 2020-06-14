package mux1;


(*synthesize*)
module mux1();

  function Bit#(1) mux1(Bit#(1) sel, Bit#(1) a, Bit#(1) b);  
  return (sel == 0)? a: b;
  endfunction :mux1

endmodule

endpackage: mux1
