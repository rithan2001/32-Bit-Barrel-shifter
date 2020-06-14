package barrel32;
import muxn::*;

//barrel left shifter
//inputvalue is input
//shiftAmt is the amt to be shifted by
//shiftValue holds remaining  empty bits remains after shift

interface Barrel_right;
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) inputvalue, Bit#(5) shiftAmt, Bit#(1) shiftValue);
endinterface

module mkBarrel_right(Barrel_right);

  method ActionValue#(Bit#(32)) rightShift(Bit#(32) inputvalue, Bit#(5) shiftAmt, Bit#(1) shiftValue);
   
    Bit#(32) shiftedVal;
    for(Integer i = 0; i < 5; i = i + 1)
      begin
      for(Integer j = 0; j < 32 - 2 ** i; j = j + 1)
        begin
        shiftedVal[j] =  inputvalue[j + 2 ** i];
        end
      for(Integer j = 0; j < 2 ** i; j = j + 1)
        begin
        shiftedVal[31 - j] = shiftValue;
        end
      inputvalue = muxn(shiftAmt[i], inputvalue, shiftedVal);
      end
    return inputvalue; 

  endmethod
endmodule

//Barrel left shifter
//inputvalue is input
//shiftAmt is the amt to be shifted by
//shiftValue holds remaining  empty bits remains after shift

interface Barrel_left;
  method ActionValue#(Bit#(32)) leftShift(Bit#(32) inputvalue, Bit#(5) shiftAmt, Bit#(1) shiftValue);
endinterface

module mkBarrel_left(Barrel_left);

  method ActionValue#(Bit#(32)) leftShift(Bit#(32) inputvalue, Bit#(5) shiftAmt, Bit#(1) shiftValue);
   
 Bit#(32) shiftedVal;
    for(Integer i = 0; i < 5; i = i + 1)
      begin
      for(Integer j = 0; j < 32 - 2 ** i; j = j + 1)
        begin
        shiftedVal[j + 2 ** i] =  inputvalue[j];
        end
      for(Integer j = 0; j < 2 ** i; j = j + 1)
        begin
        shiftedVal[j] = shiftValue;
        end
      inputvalue = muxn(shiftAmt[i], inputvalue, shiftedVal);
      end
    return inputvalue;
  endmethod
endmodule


//Logical barrel right shifter
// empty bit is 0
interface Logicalrightshifter;
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
endinterface

module mkLogicalrightshifter(Logicalrightshifter);
  let obj1 <- mkBarrel_right;
  
  method ActionValue#(Bit#(32))  rightShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
  
    let outputvalue = obj1.rightShift(inputvalue, shiftAmt, 0);
    let result <- outputvalue;
    return result;
  endmethod
endmodule



//Logical barrel left shifter
// empty bit is 0
interface Logicalleftshifter;
  method ActionValue#(Bit#(32)) leftShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
endinterface

module mkLogicalleftshifter(Logicalleftshifter);
  let obj2 <- mkBarrel_left;
  method ActionValue#(Bit#(32)) leftShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
  
    let outputvalue = obj2.leftShift(inputvalue, shiftAmt, 0);
    let result <- outputvalue;
    return result;
  endmethod
endmodule




//arithmetic barrel right shifter
//empty bit is filled with highest weighted bit
interface Arithmeticrightshifter;
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
endinterface

module mkArithmeticrightshifter(Arithmeticrightshifter);
  let obj1 <- mkBarrel_right;
  method ActionValue#(Bit#(32)) rightShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
  
    let outputvalue = obj1.rightShift(inputvalue, shiftAmt, inputvalue[31]);

    let result <- outputvalue;
    return result;
  endmethod
endmodule


//arithmetic barrel left shifter
//empty bit is filled with least weighted bit
interface Arithmeticleftshifter;
  method ActionValue#(Bit#(32)) leftShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
endinterface

module mkArithmeticleftshifter(Arithmeticleftshifter);
  let obj2 <- mkBarrel_left;
  method ActionValue#(Bit#(32)) leftShift(Bit#(32) inputvalue, Bit#(5) shiftAmt);
  
    let outputvalue = obj2.leftShift(inputvalue, shiftAmt, inputvalue[0]);

    let result <- outputvalue;
    return result;
  endmethod
endmodule




endpackage

