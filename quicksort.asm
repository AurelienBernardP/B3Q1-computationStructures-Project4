|; void quickSort(int* array, int size)
|;   @param array A pointer to the array
|;   @param size Size of the array
quickSort:
    PUSH(LP)
    PUSH(BP)
    ADDC(SP,0,DP)
    PUSH(R1) ;will hold array
    PUSH(R2) ;will hold n
    PUSH(R3) ;will hold maxd(unused in quicksort)
    PUSH(R20) ; will e used to hold comparisons
    LD(BP,-12,R1) ; load array
    LD(BP,-16,R2) ; load n
    LD(BP,-20,R3) ; load maxd
    CMPLTC(R2,1,R20); n > 1 
    BNE(R20, mainLoop)

mainLoop:
    ;test for maxd and switch to heapsort if needed
    ;SUBC(R3,1,R3)
    PUSH(R4); will hold i
    PUSH(R5) ; will hold l
    PSUH(R6) ; will hold r
    PUSH(R2);PUSH second arg
    PUSH(R1);PUSH first arg
    BEQ(R31, median3, LP) ; call procedure, R0 will hold pivot value
    POP(R1) ;POP first arg
    POP(R2) ;POP second arg
    ADDC(R31,0,R4) ; put 0 in i
    ADDC(R31,0,R5) ; put 0 in l
    ADDC(R31,0, R2); put n in r
    CMPLT(R4,R6,R20); evaluate i<r
    BEQ(R20, loop3part) ; if true enter loop
    BEQ(R31, continue, R31) ; if false, continue



median3:
    PUSH(LP)
    PUSH(BP)
    ADDC(SP,0,DP)
    PUSH(R1)
    PUSH(R2)
    PUSH(R3)
    PUSH(R4)
    PUSH(R5)
    LD(BP,-12,R1)
    LD(BP,-16,R2)
    SHR(R2,1,R4)
    SUBC(R2,1,R5)
    LD(R1,0,R3)
    LDARR(R1,R4,R4)
    LDARR(R1,R5,R5)
    CMPLT(R3,R4,R20)
    BEQ (R20,BgrtA)
    CMPLT(R4,R5,R20)
    BEQ(R20, CgrtB)
    BEQ(R31,returnB,R31)

BgrtA:
    CMPLT(R4,R5,R20)
    BEQ(R20, returnB)
    CMPLT(R3,R5,R20)
    BEQ(R20,returnC)
    BEQ(R31,returnA,R31)
CgrtB:
    CMPLT(R3,R5,R20)
    BEQ(R20, returnA)
    BEQ(R31,returnC,R31)

returnA:
    ADD(R3,R31,R0)
    BEQ(R31,restoreMedian,R31)
returnB:
    ADD(R4,R31,R0)
    BEQ(R31,restoreMedian,R31)
returnC:
    ADD(R5,R31,R0)
    BEQ(R31,restoreMedian,R31)

restoreMedian:
    POP(R5)
    POP(R4)
    POP(R3)
    POP(R2)
    POP(R1)
    ADDC(BP,0,LP)
    POP(BP)
    POP(LP)
    JMP(LP, R31)

loop3part: 
    LDARR(R1,R4,R7)
    LDARR(R1, R6, R8)
    CMP(R7,R8)
    JL part1
    CMP(R7,R0)
    JL part2
    ADDC(R4,1,R4)
    CMP(R4,R6)
    JL loop3part
    BEQ(R31, continue, R31)

part1:
    SWAP(ADR(R1,R4,YES)ADR(R1,R5,YES))
    ADDC(R4,1,R4)
    ADDC(R6,1,R6)
    CMP(R4,R6)
    JL loop3part
    BEQ(R31, continue, R31)
part2:
    SUBC(R6,1,R6)
    SWAP(ADR(R1,R4,YES)ADR(R1,R6,YES))
    CMP(R4,R6)
    JL loop3part
    BEQ(R31, continue, R31)

continue:
    ;push all the arguments on stack
    ;push LP BP
    BEQ(R31, quickSort, LP)
    ;pop all the arguments off stack
    ADR(R1,R6,R1)
    SUB(R2,R6,R2)
    CMPC(R2,1)
    JG mainLoop
    ;pop all used registers
    ;pop BP LP
    JMP(LP, R31)