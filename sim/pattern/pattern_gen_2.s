.data
  num: .word  0
  
 .text
.globl __start

__start:
	li x1, 1
	li x2, 2
	li x3, 3
	li x4, 4
	li x5, 5
	li x6, 6
	addi x7, x1, 127
	xori x8, x7, 127
	slli x9, x2, 4
	sll x10, x9, x3
	sub x11, x10, x4
	xor x12, x11, x3
	and x13, x12, x8
	andi x14, x13, 6
	ori x15, x14, 249
	add x16, x7, x15
	srl x17, x16, x1
	or x18, x17, x16
	srli x19, x18, 1
	srai x20, x19, 3
	sra x21, x20, x1
	slti x21, x20, 32
	slt x22, x20, x9

	la x23, num
	sw x1, 0(x23)
	sw x2, 4(x23)
	sw x3, 8(x23)
	sw x4, 12(x23)
	sw x5, 16(x23)
	sw x6, 20(x23)
	sw x7, 24(x23)
	sw x8, 28(x23)
	sw x9, 32(x23)
	sw x10, 36(x23)
	sw x11, 40(x23)
	sw x12, 44(x23)
	sw x13, 48(x23)
	sw x14, 52(x23)
	sw x15, 56(x23)
	sw x16, 60(x23)
	sw x17, 64(x23)
	sw x18, 68(x23)
	sw x19, 72(x23)
	sw x20, 76(x23)
	sw x21, 80(x23)
	sw x22, 84(x23)
	add x0, x0, x0
        ecall
