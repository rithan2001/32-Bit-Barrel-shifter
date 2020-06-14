package barrel32tb;
import barrel32::*;

module mkbarrel32tb(Empty);
Reg#(Bit#(32)) state <- mkReg(0);
Barrel_right n <- mkBarrel_right();
Logicalrightshifter  m <- mkLogicalrightshifter();
Arithmeticrightshifter p <- mkArithmeticrightshifter();

Barrel_left q <- mkBarrel_left();
Logicalleftshifter  r <- mkLogicalleftshifter();
Arithmeticleftshifter s <- mkArithmeticleftshifter();

rule go (state ==0);
let k= m.rightShift(23,2);
let l= p.rightShift(23,2);
$display("logical barrel right shifter= %d ",k);

$display("\n Arithmetic barrel right shifter= %d ",l);


let a= r.leftShift(23,2);
let b= s.leftShift(23,2);
$display("logical barrel left shifter= %d ",a);

$display("\n Arithmetic barrel left  shifter= %d ",b);


$finish;
state <= 1;
endrule 

endmodule


endpackage
