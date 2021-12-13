
.data
    n: .word 7
    
.text
.globl __start

FUNCTION:
    # Todo: Define your own function in HW1
    addi a3, a0, 0
    li a0, 7        # initial T(1)=7
    li a1, 1        # set end number=1
    addi a2, a3, 0
    beq a3, a1, result    # when input=1, directly go to result
T:
    addi sp, sp, -4       # before go to next recurrence store current number
    sw a2, 0(sp)
    srli a2, a2, 1
    bne a2, a1, T
A:
    beq a2, a3, result    # when tracing back to n, then end
    lw a2, 0(sp)
    addi sp, sp, 4
    slli a0, a0, 3        # 8*T(n/2)
    slli t1, a2, 2        # 4*n
    add a0, a0, t1
    j A
result:
    jr ra

# Do NOT modify this part!!!
__start:
    la   t0, n
    lw   x10, 0(t0)
    jal  x1,FUNCTION
    la   t0, n
    sw   x10, 4(t0)
    addi a0,x0,10
    ecall
