package muxn;



  function Bit#(1) mux1(Bit#(1) sel, Bit#(1) a, Bit#(1) b);  
  return (sel == 0)? a: b;
  endfunction :mux1

function Bit#(32) muxn(Bit#(1) sel, Bit#(32) a, Bit#(32) b);
  Bit#(32) aggregate = 0;
  for (Integer i = 0; i < 32; i = i+1)
   begin
    aggregate[i] = mux1(sel, a[i], b[i]);
   end
return aggregate;
endfunction

//endmodule

endpackage: muxn
