

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

|; void introsort(int* array, int size, int maxd)
|;   @param array A pointer to the array
|;   @param size Size of the array
|;   @param maxd Maximum number of recursive calls
introsort:
    PUSH(LP)
    PUSH(BP)
    ADDC(SP,0,BP)
    PUSH(R1) |;will hold array
    PUSH(R2) |;will hold n
    PUSH(R3) |;will hold maxd
    PUSH(R20) |; will be used to hold comparisons
    LD(BP,-12,R1) |; load array
    LD(BP,-16,R2) |; load n
    LD(BP,-20,R3) |; load maxd
    CMPLEC(R2,1,R20)|; n <= 1
    BEQ(R20, mainLoop) |;if n > 1 jump to mainloop
    BEQ(R31, returnintro)

mainLoop:
    CMPLEC(R3,0,R20)|;test for maxd and switch to heapsort if needed
    BNE(R20, swapToheap)
    SUBC(R3,1,R3) |; maxd--
    PUSH(R4)|; will hold i
    PUSH(R5) |; will hold l
    PUSH(R6) |; will hold r
    PUSH(R2)|;PUSH second arg
    PUSH(R1)|;PUSH first arg
    BEQ(R31, median3, LP) |; call procedure, R0 will hold pivot value
    POP(R1) |;POP first arg
    POP(R2) |;POP second arg
    ADDC(R31,0,R4) |; put 0 in i
    ADDC(R31,0,R5) |; put 0 in l
    ADD(R31,R2, R6)|; put n in r
    CMPLT(R4,R6,R20)|; evaluate i<r
    BNE(R20, loop3part) |; if i<r enter loop
    BEQ(R31, continue, R31) |; if false, continue

swapToheap:
    PUSH(R2)|;PUSH second arg
    PUSH(R1)|;PUSH first arg
    BEQ(R31, heapsort, LP)
    POP(R1) |;POP first arg
    POP(R2) |;POP second arg
    BEQ(R31, returnintro, 31)

|; void median3(int* array, int size)
|;   @param array A pointer to the array
|;   @param size Size of the array
|;   @return The median value from of first middle and last element of array
median3:
    PUSH(LP)
    PUSH(BP)
    ADDC(SP,0,BP)
    PUSH(R1)|;R1 will hold arg1 array
    PUSH(R2)|;R2 will hold arg2 n
    PUSH(R3)|;R3 will hold a
    PUSH(R4)|;R4 will hold b 
    PUSH(R5)|;R5 will hold c
    LD(BP,-12,R1)|;get arg 1 array
    LD(BP,-16,R2)|;get arg 2 n
    SHRC(R2,1,R4) |; r4 = n/2
    SUBC(R2,1,R5)|; r5 = n-1
    LDARR(R1,R31,R3) |;r3 = array[0] a
    LDARR(R1,R4,R4)|; r4 = array[n/2] b
    LDARR(R1,R5,R5)|; r5 = array[n-1] c 
    CMPLT(R3,R4,R20)|; if a < b
    BNE (R20,BgrtA)|; a< b true
    CMPLT(R4,R5,R20) |; else if b<c 
    BNE(R20, CgrtB)
    BEQ(R31,returnB,R31)

BgrtA:
    CMPLT(R4,R5,R20)
    BNE(R20, returnB)
    CMPLT(R3,R5,R20)
    BNE(R20,returnC)
    BEQ(R31,returnA,R31)
CgrtB:
    CMPLT(R3,R5,R20)
    BNE(R20, returnA)
    BEQ(R31,returnC,R31)

returnA:
    ADD(R3,R31,R0)|;place return value of median3 in R0
    BEQ(R31,restoreMedian,R31)
returnB:
    ADD(R4,R31,R0)|;place return value of median3 in R0
    BEQ(R31,restoreMedian,R31)
returnC:
    ADD(R5,R31,R0)|;place return value of median3 in R0
    BEQ(R31,restoreMedian,R31)

|;restore the stack and registers as before entering the median3 function
restoreMedian:
    POP(R5) 
    POP(R4)
    POP(R3)
    POP(R2)
    POP(R1)
    ADDC(BP,0,SP)
    POP(BP)
    POP(LP)
    JMP(LP, R31)

loop3part:
    PUSH(R7) |; R7 will hold array[i] 
    LDARR(R1,R4,R7) |; put array[i] in R7
    CMPLT(R7,R0,R20) |; array[i] < pivot
    BNE (R20,part1) |; if array[i] < pivot == true jump to part1
    CMPLT(R0,R7,R20) |; pivot <= array[i]
    BNE(R20, part2) |;  else if array[i] <= pivot == flase jump to part2
    ADDC(R4,1,R4) |; else case
    POP(R7)
    CMPLT(R4,R6,R20) |; guardian
    BNE(R20, loop3part) |; loop
    BEQ(R31, continue, R31) |; exit

part1:
    POP(R7)
    PUSH(R8)
    PUSH(R9)
    PUSH(R10) |; tmp1
    PUSH(R11) |; tmp2
    ADDR(R1,R4,R8) |; R8 = array + i
    ADDR(R1,R5,R9) |; R9 = array + l
    SWAP(R8, R9, R10,R11) |;swap(array + i, array + l)|;
    POP(R11)
    POP(R10)
    POP(R9)
    POP(R8)
    ADDC(R4,1,R4) |; i ++
    ADDC(R5,1,R5) |; l ++
    CMPLT(R4,R6,R20) |;Guardian
    BNE(R20, loop3part) |; loop
    BEQ(R31, continue, R31) |;exit loop
part2:
    POP(R7)
    SUBC(R6,1,R6) |;r--
    PUSH(R8)
    PUSH(R9)
    PUSH(R10) |; tmp1
    PUSH(R11) |; tmp2
    ADDR(R1,R4,R8) |; R8 = array + i
    ADDR(R1,R6,R9) |; R9 = array + r
    SWAP(R8, R9, R10,R11) |;swap(array + i, array + r)|;
    POP(R11)
    POP(R10)
    POP(R9)
    POP(R8)
    CMPLT(R4,R6,R20) |;guardian
    BNE(R20, loop3part) |;loop
    BEQ(R31, continue, R31) |; exit loop

continue:
    PUSH(R3) |; push arguments
    PUSH(R5)
    PUSH(R1)
    BEQ(R31, introsort, LP) |; recursive call
    POP(R1) |; pop arguments
    POP(R5)
    POP(R3)
    PUSH(R15) |; start array +=r
    ADDR(R1,R6,R15) 
    ADD(R31,R15,R1)
    POP(R15) |; end array += r
    SUB(R2,R6,R2)
    POP(R6)|;POP mainloop local variables
    POP(R5)
    POP(R4)   
    CMPLEC(R2,1,R20)|;guardian main loop n <= 1
    BEQ(R20, mainLoop) |; if false loop
    BEQ(R31, returnintro)


returnintro:
    POP(R20)
    POP(R3)|; pop to the registers holding the arguments
    POP(R2)
    POP(R1)
    ADDC(BP, 0, SP)
    POP(BP)|;POP BP LP
    POP(LP)
    JMP(LP, R31)|;Return 