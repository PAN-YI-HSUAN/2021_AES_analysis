.data
    rcon0: .word 0x01
    rcon1: .word 0x02
    rcon2: .word 0x04
    rcon3: .word 0x08
    rcon4: .word 0x10
    rcon5: .word 0x20
    rcon6: .word 0x40
    rcon7: .word 0x80
    rcon8: .word 0x1B
    rcon9: .word 0x36
    ct0: .word 0xd8e0c469
    ct1: .word 0x30047b6a
    ct2: .word 0x80b7cdd8
    ct3: .word 0x5ac5b470
    key0: .word 0x03020100
    key1: .word 0x07060504
    key2: .word 0x0b0a0908
    key3: .word 0x0f0e0d0c
    rk0: .word 0

.globl __start
.text

__start:

aes128_dec_key:

    la      a0, rk0
    la      a1, key0
    la      a2, rcon0

    addi	sp,		sp,		-8
    sw		s0,		0(sp)
    sw		ra,		4(sp)
    mv		s0,		a0
    call	aes128_enc_key
    addi	a0,		s0,		16
    lw		s0,		0(sp)
    lw		ra,		4(sp)
    addi	a1,		a0,		144
    addi	sp,		sp,		8
    j	invmc

aes128_enc_key:

    addi	a3,		a0,		160	#	end pointer

    lw		t0,		0(a1)				#	input key
    lw		t1,		4(a1)
    lw		t2,		8(a1)
    lw		t3,		12(a1)

    sw		t0,		0(a0)				#	first round key
    sw		t1,		4(a0)
    sw		t2,		8(a0)
    sw		t3,		12(a0)

    xori	t0,		t0,		1			#	first round constant
    j		nl0

ekl0:
    addi	a2,		a2,		4
    lw		a1,		0(a2)				#	round constant
    xor		t0,		a1,		t0

nl0:
    slli	a4,		t3,		24			#	rotate
    srli	a1,		t3,		8
    or		a1,		a1,		a4

    saes32_encs		t0, t0, a1, 0
    saes32_encs		t0, t0, a1, 1
    saes32_encs		t0, t0, a1, 2
    saes32_encs		t0, t0, a1, 3

    xor		t1,		t1,		t0
    xor		t2,		t2,		t1
    xor		t3,		t3,		t2

    addi	a0,		a0,		16
    sw		t0,		0(a0)				#	store round key
    sw		t1,		4(a0)
    sw		t2,		8(a0)
    sw		t3,		12(a0)

    bne		a0,		a3,		ekl0
    jr		ra

invmc:
    lw		t0,		0(a0)

    saes32_encs		t1, x0,	t0, 0
    saes32_encs		t1, t1, t0, 1
    saes32_encs		t1, t1, t0, 2
    saes32_encs		t1, t1, t0, 3

    saes32_decsm	t0, x0,	t1, 0
    saes32_decsm	t0, t0, t1, 1
    saes32_decsm	t0, t0, t1, 2
    saes32_decsm	t0, t0, t1, 3

    sw		t0,		0(a0)
    addi	a0,		a0,		4
    bne		a0,		a1,		invmc
    
aes_dec_rounds:

    la      a1,     ct0
    la      a2,     rk0
    addi    a0,     a2,     176
    addi    a3,     x0,     10

    lw		t4,		0(a1)				#	load ct
    lw		t5,		4(a1)
    lw		t6,		8(a1)
    lw		a7,		12(a1)

    slli	a3,		a3,		4			#	final pointer
    add		a3,		a3,		a2

    lw		t0,		0(a3)				#	load rk
    lw		t1,		4(a3)
    lw		t2,		8(a3)
    lw		t3,		12(a3)

    xor		t0,		t0,		t4			#	ct ^ rk
    xor		t1,		t1,		t5
    xor		t2,		t2,		t6
    xor		t3,		t3,		a7

    j		ent						#	enter loop in middle

loop:
    #	even round
    saes32_decsm	t0, t0, t4, 0
    saes32_decsm	t0, t0, a7, 1
    saes32_decsm	t0, t0, t6, 2
    saes32_decsm	t0, t0, t5, 3

    saes32_decsm	t1, t1, t5, 0
    saes32_decsm	t1, t1, t4, 1
    saes32_decsm	t1, t1, a7, 2
    saes32_decsm	t1, t1, t6, 3

    saes32_decsm	t2, t2, t6, 0
    saes32_decsm	t2, t2, t5, 1
    saes32_decsm	t2, t2, t4, 2
    saes32_decsm	t2, t2, a7, 3

    saes32_decsm	t3, t3, a7, 0
    saes32_decsm	t3, t3, t6, 1
    saes32_decsm	t3, t3, t5, 2
    saes32_decsm	t3, t3, t4, 3

ent:
    addi	a3,		a3,		-32
    lw		t4,		16(a3)				#	load round key
    lw		t5,		20(a3)
    lw		t6,		24(a3)
    lw		a7,		28(a3)

    #	odd round
    saes32_decsm	t4, t4, t0, 0
    saes32_decsm	t4, t4, t3, 1
    saes32_decsm	t4, t4, t2, 2
    saes32_decsm	t4, t4, t1, 3

    saes32_decsm	t5, t5, t1, 0
    saes32_decsm	t5, t5, t0, 1
    saes32_decsm	t5, t5, t3, 2
    saes32_decsm	t5, t5, t2, 3

    saes32_decsm	t6, t6, t2, 0
    saes32_decsm	t6, t6, t1, 1
    saes32_decsm	t6, t6, t0, 2
    saes32_decsm	t6, t6, t3, 3

    saes32_decsm	a7, a7, t3, 0
    saes32_decsm	a7, a7, t2, 1
    saes32_decsm	a7, a7, t1, 2
    saes32_decsm	a7, a7, t0, 3

    lw		t0,		0(a3)				#	load round key
    lw		t1,		4(a3)
    lw		t2,		8(a3)
    lw		t3,		12(a3)
    bne		a3,		a2,		loop

    #	final (output) round
    saes32_decs		t0, t0, t4, 0
    saes32_decs		t0, t0, a7, 1
    saes32_decs		t0, t0, t6, 2
    saes32_decs		t0, t0, t5, 3

    saes32_decs		t1, t1, t5, 0
    saes32_decs		t1, t1, t4, 1
    saes32_decs		t1, t1, a7, 2
    saes32_decs		t1, t1, t6, 3

    saes32_decs		t2, t2, t6, 0
    saes32_decs		t2, t2, t5, 1
    saes32_decs		t2, t2, t4, 2
    saes32_decs		t2, t2, a7, 3

    saes32_decs		t3, t3, a7, 0
    saes32_decs		t3, t3, t6, 1
    saes32_decs		t3, t3, t5, 2
    saes32_decs		t3, t3, t4, 3

    sw		t0,		0(a0)				#	store pt
    sw		t1,		4(a0)
    sw		t2,		8(a0)
    sw		t3,		12(a0)
    add     x0,     x0,     x0
    ecall