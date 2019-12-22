|; void quickSort(int* array, int size)
|;   @param array A pointer to the array
|;   @param size Size of the array
quickSort

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
    SHL(R2,1,R4)
    SUBC(R2,1,R5)
    LD(R1,0,R3)
    LDARR(R1,R4,R4)
    LDARR(R1,R5,R5)
    CMP(R3,R4)
    JL BgrtA
    CMP(R4,R5)
    JL CgrtB
    BEQ(R31,returnB,R31)
BgrtA:
    CMP(R4,R5)
    JL returnB
    CMP(R3,R5)
    JL returnC
    BEQ(R31,returnA,R31)
CgrtB:
    CMP(R3,R5)
    JL returnA
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



