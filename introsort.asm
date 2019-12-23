

|; void sort(int* array, int size)
|;   @param array A pointer to the array
|;   @param size Size of the array 
sort:
  PUSH(LP) PUSH(BP)
  ADDC(SP,0,BP)
  PUSH(R1)
  PUSH(R2)
  PUSH(R0)
  PUSH(R20)
  LD(BP,-12,R1) |; load array
  LD(BP,-16,R2) |; load size
  CMPEQ(R2,R31,R20)|; evaluate SIZE == 0
  BNE(R20, return) |; if r20 == 1 return
  PUSH(R2)|;Push the size
  BEQ(R31, log2, LP)
  POP(R2)
  ADDC(R0,0,R3)
  POP(R0)
  PUSH(R3)
  PUSH(R2)
  PUSH(R1)
  BEQ(R31, introsort, LP)
  BEQ(R31, return, R31)

return:
  POP(R20)
  POP(R0)
  POP(R2)
  POP(R1)
  ADDC(BP, 0, SP)
  POP(BP)|;POP BP LP
  POP(LP)
  JMP(LP, R31)|;Return 




