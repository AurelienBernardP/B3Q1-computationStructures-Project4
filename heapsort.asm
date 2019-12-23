
|; void heapsify(int* array, int size, int index)
|;   @param array A pointer to the array
|;   @param size Size of the array 
|;   @param index An index of the array 
heapify:
      PUSH(LP) PUSH(BP) |; save previous fram & return address
      ADDC (SP, 0, BP) |; init current frame
      PUSH (R10) |; local variables
      PUSH (R9) |; local variables
      PUSH (R8) |; local variables
      PUSH (R7) |; local variables
      PUSH (R6) |; local variables
      PUSH (R5) |; local variables
      PUSH (R4) |; local variables
      PUSH (R3) |; local variables
      PUSH (R2) |; local variables
      PUSH (R1) |; local variables
      LD (BP, -20, R3) |; R3 = argument 3 = index of array
      LD (BP, -16, R2) |; R2 = argument 2 = size of array
      LD (BP, -12, R1) |; R1 = argument 1 = address of array
loopify:
      CMPLT(R3,R2,R10) |; index < size then r10 = 1
      BEQ(R10,end,R31) |; if R10 = 0 then function endifys
      ADDC(R3,0,R5) |;  largest = index
      MULC(R3,2,R6) |; R6 = index * 2
      ADDC(R6,1,R6) |; R6 = left = (index * 2) + 1
      ADDC(R3,1,R7) |; R7 = index + 1
      MULC(R7,2,R7) |; R7 = right =(index + 1) * 2
      CMPLT(R6,R2,R8) |; left < size then R8 = 1
      LDARR(R1,R6,R9) |; R9 = array[left]
      LDARR(R1,R5,R4) |; R4 = array[largest]
      CMPLT(R4,R9,R9) |; array[largest] < array[left] then R9 = 1
      AND(R8,R9,R9)
      BEQ(R9,next,R31)|; R9 != R8 then next
      ADDC(R6,0,R5) |; largest = left
next: CMPLT(R7,R2,R8) |; right < size then R8 = 1
      LDARR(R1,R7,R9) |; R9 = array[right]
      LDARR(R1,R5,R4) |; R4 = array[largest]
      CMPLT(R4,R9,R9) |; array[largest] < array[right] then R9 = 1
      AND(R8,R9,R9)
      BEQ(R9,next2,R31)|; R9 != R8
      ADDC(R7,0,R5) |; largest = right
next2:CMPEQ(R5,R3,R9) |; if R5 (largest) = R3 (index) then function ends
      BNE(R9,endify,R31)
      ADDR(R1,R5,R8) |; R8 = address of array + largest
      ADDR(R1,R3,R9) |; R8 = address of array + index
      SWAP(R8,R9,R4,R3) |; swap the elements of array
      ADDC(R5,0,R3) |; index = largest
      BEQ(R31,loopify,R31)
endify: 
      POP (R1) |; deallocating variables
      POP (R2)
      POP (R3)
      POP (R4)
      POP (R5)
      POP (R6)
      POP (R7)
      POP (R8)
      POP (R9)
      POP (R10)
      ADDC(BP, 0, SP)
      POP(BP)
      POP(LP)
      JMP(LP, R31)

|; void heapsort(int* array, int size)
|;   @param array A pointer to the array
|;   @param size Size of the array 
heapsort:
      PUSH(LP) PUSH(BP) |; save previous fram & return address
      ADDC (SP, 0, BP) |; init current frame
      PUSH (R7) |; local variables
      PUSH (R6) |; local variables
      PUSH (R5) |; local variables
      PUSH (R4) |; local variables
      PUSH (R3) |; local variables
      PUSH (R2) |; local variables
      PUSH (R1) |; local variables
      LD (BP, -16, R2) |; R2 = argument 2 = size of array
      LD (BP, -12, R1) |; R1 = argument 1 = array address
      DIVC (R2, 2, R3) |; R3 = R2 / 2 = size/2
      SUBC(R3, 1, R3) |; R3 = (size/2)-1
loop: CMPLE(R31,R3,R6) |; if 0 <= R3 then r6 = 1
      BEQ(R6,skip,R31) |; if r6 = 0 then skip
      PUSH (R3) |; index argument 3 for heapify
      PUSH (R2) |; size argument 2 for heapify
      PUSH (R1) |; array argument 1 for heapify
      BEQ (R31, heapify, LP) |;Call heapify with LP to this address
      POP (R1) |; deallocating argument
      POP (R2) |; deallocating argument
      POP (R3) |; deallocating argument
      SUBC(R3, 1, R3) |; R3--;
      BEQ(R31, loop, R31)
skip: SUBC(R2, 1, R3) |; R3 = size -1
      BEQ(R3, end, R31) |; if R3 = 0, function ends
loop2:ADDR(R1, R3, R7) |; R2 = R1 + R3*4
      SWAP(R1,R7, R5, R6) |; swap: R1 = R2 & R2 = R1
      PUSH (R31) |; index argument 3 for heapify
      PUSH (R3) |; size argument 2 for heapify
      PUSH (R1) |; array argument 1 for heapify
      BEQ (R31, heapify, LP) |;Call heapify with LP to this address
      POP (R1) |; deallocating argument
      POP (R3) |; deallocating argument
      POP (R31) |; deallocating argument
      SUBC(R3, 1, R3) |; R3 --
      BNE(R3, loop2, R31) |; loop while R3 != 0
end:  POP(R1)|; deallocating variables
      POP(R2)
      POP(R3)
      POP(R4)
      POP(R5)
      POP(R6)
      POP(R7)
      ADDC(BP, 0, SP)
      POP(BP)
      POP(LP)
      JMP(LP, R31)

