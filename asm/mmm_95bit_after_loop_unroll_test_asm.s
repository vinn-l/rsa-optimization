	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"mmm_95bit_after_loop_unroll_test.c"
	.text
	.align	2
	.global	add_uint96
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	add_uint96, %function
add_uint96:
	@ args = 12, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	sub	sp, sp, #20
	add	lr, sp, #16
	stmdb	lr, {r1, r2, r3}
	ldr	r1, [sp, #12]
	ldr	lr, [sp, #56]
	mov	r5, #0
	adds	r6, lr, r1
	adc	r7, r5, #0
	ldr	r2, [sp, #52]
	mov	r9, #0
	ldr	r4, [sp, #8]
	adds	r2, r2, r4
	adc	r3, r9, #0
	adds	r8, r2, r7
	adc	r9, r3, r7, asr #31
	ldr	r4, [sp, #48]
	ldr	r6, [sp, #4]
	adds	r2, r4, r6
	adds	r4, r2, r9
	str	r4, [r0]
	str	r8, [r0, #4]
	add	r1, r1, lr
	str	r1, [r0, #8]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
	.size	add_uint96, .-add_uint96
	.align	2
	.global	sub_uint96
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	sub_uint96, %function
sub_uint96:
	@ args = 12, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #36
	add	lr, sp, #32
	stmdb	lr, {r1, r2, r3}
	ldr	r3, [sp, #28]
	adds	r6, r3, #0
	mov	r3, #0
	adc	r7, r3, #1
	ldr	r3, [sp, #80]
	subs	r4, r6, r3
	sbc	r5, r7, #0
	mvn	r2, #0
	mov	r3, #0
	strd	r4, [sp, #8]
	cmp	r5, r3
	cmpeq	r4, r2
	movls	r1, #1
	movhi	r1, #0
	mov	lr, #0
	ldr	r7, [sp, #24]
	adds	r10, r7, lr
	adc	fp, lr, #1
	ldr	r7, [sp, #76]
	subs	r4, r10, r7
	sbc	r5, fp, #0
	subs	r8, r4, r1
	sbc	r9, r5, lr
	cmp	r9, r3
	cmpeq	r8, r2
	movls	r3, #1
	movhi	r3, lr
	ldr	r2, [sp, #20]
	adds	r2, r2, lr
	str	r2, [sp]
	adc	r2, lr, #1
	str	r2, [sp, #4]
	ldr	r2, [sp, #72]
	ldrd	r10, [sp]
	subs	r10, r10, r2
	subs	r10, r10, r3
	str	r10, [r0]
	str	r8, [r0, #4]
	ldr	r3, [sp, #8]
	str	r3, [r0, #8]
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	sub_uint96, .-sub_uint96
	.align	2
	.global	cmp_uint96
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	cmp_uint96, %function
cmp_uint96:
	@ args = 16, pretend = 8, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
	sub	sp, sp, #16
	add	ip, sp, #16
	stmdb	ip, {r0, r1, r2}
	str	r3, [sp, #20]
	ldr	r2, [sp, #4]
	cmp	r2, r3
	movhi	r0, #0
	bhi	.L5
	movne	r0, #1
	beq	.L12
.L5:
	add	sp, sp, #16
	@ sp needed
	add	sp, sp, #8
	bx	lr
.L12:
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #24]
	cmp	r2, r3
	movcc	r0, #0
	bcc	.L5
	movne	r0, #1
	bne	.L5
	ldr	r0, [sp, #12]
	ldr	r3, [sp, #28]
	cmp	r0, r3
	movcs	r0, #0
	movcc	r0, #1
	b	.L5
	.size	cmp_uint96, .-cmp_uint96
	.align	2
	.global	rshift1_uint96
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	rshift1_uint96, %function
rshift1_uint96:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	add	lr, sp, #16
	stmdb	lr, {r1, r2, r3}
	ldr	r3, [sp, #4]
	ldr	r1, [sp, #8]
	lsl	r2, r1, #31
	ldr	lr, [sp, #12]
	add	r2, r2, lr, lsr #1
	lsr	lr, r3, #1
	str	lr, [r0]
	lsl	r3, r3, #31
	add	r3, r3, r1, lsr #1
	str	r3, [r0, #4]
	str	r2, [r0, #8]
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
	.size	rshift1_uint96, .-rshift1_uint96
	.align	2
	.global	rshift32_uint96
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	rshift32_uint96, %function
rshift32_uint96:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	add	lr, sp, #16
	stmdb	lr, {r1, r2, r3}
	mov	r3, #0
	str	r3, [r0]
	ldr	r3, [sp, #4]
	str	r3, [r0, #4]
	ldr	r3, [sp, #8]
	str	r3, [r0, #8]
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
	.size	rshift32_uint96, .-rshift32_uint96
	.align	2
	.global	print_uint96
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	print_uint96, %function
print_uint96:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #28
	add	ip, sp, #24
	stmdb	ip, {r1, r2, r3}
	ldr	r3, [sp, #20]
	str	r3, [sp]
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #12]
	mov	r1, r0
	movw	r0, #:lower16:.LC10
	movt	r0, #:upper16:.LC10
	bl	printf
	add	sp, sp, #28
	@ sp needed
	ldr	pc, [sp], #4
	.size	print_uint96, .-print_uint96
	.align	2
	.global	modular_multiplication_32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	modular_multiplication_32x3, %function
modular_multiplication_32x3:
	@ args = 28, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #68
	str	r0, [sp, #48]
	add	r0, sp, #64
	stmdb	r0, {r1, r2, r3}
	ldr	r3, [sp, #52]
	str	r3, [sp, #8]
	ldr	r3, [sp, #56]
	str	r3, [sp, #4]
	ldr	r3, [sp, #60]
	str	r3, [sp, #12]
	ldr	r1, [sp, #112]
	str	r1, [sp, #32]
	ldr	r3, [sp, #128]
	cmp	r3, #0
	ble	.L20
	and	fp, r1, #1
	mov	r9, #0
	mov	r6, r9
	mov	r8, r9
	str	r9, [sp, #16]
	mov	r10, r9
	mov	r2, r1
	mov	r3, #0
	strd	r2, [sp, #24]
	b	.L60
.L99:
	ldr	r7, [sp, #12]
	ldr	r3, [sp, #4]
	str	r3, [sp, #12]
	ldr	r3, [sp, #8]
	str	r3, [sp, #4]
	mov	r3, #0
	str	r3, [sp, #8]
	b	.L21
.L100:
	ldr	r3, [sp, #104]
	str	r3, [sp, #36]
	ldr	ip, [sp, #108]
	ldrd	r4, [sp, #24]
	adds	r4, r4, r6
	adc	r5, r5, #0
	ldr	r1, [sp, #32]
	add	r6, r6, r1
	mov	r1, #0
	adds	r0, ip, r9
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r9, r4
	mov	r2, r3
	adds	r0, r2, r8
	adds	r2, r0, r5
	mov	r8, r2
	ldr	r0, [sp, #36]
	cmp	r2, r0
	bhi	.L22
	mov	r2, r0
	beq	.L89
.L74:
	add	r10, r10, #1
	b	.L22
.L89:
	cmp	r4, ip
	bhi	.L22
	bne	.L74
	ldr	r1, [sp, #32]
	cmp	r6, r1
	movcs	r9, ip
	ldrcs	r8, [sp, #36]
	bcs	.L22
	b	.L74
.L101:
	ldr	r3, [sp, #116]
	str	r3, [sp, #20]
	ldr	ip, [sp, #120]
	ldr	r3, [sp, #124]
	str	r3, [sp, #36]
	mov	r2, r3
	mov	r3, #0
	adds	r4, r2, r6
	adc	r5, r3, #0
	ldr	r3, [sp, #36]
	add	r6, r6, r3
	mov	r3, #0
	adds	r2, ip, r9
	adc	r3, r3, #0
	adds	r4, r2, r5
	adc	r5, r3, r5, asr #31
	mov	r9, r4
	ldr	r2, [sp, #20]
	adds	r2, r2, r8
	adds	r0, r2, r5
	mov	r8, r0
	ldr	r2, [sp, #20]
	cmp	r0, r2
	bhi	.L25
	beq	.L90
.L73:
	add	r10, r10, #1
	b	.L25
.L90:
	cmp	r4, ip
	bhi	.L25
	bne	.L73
	ldr	r3, [sp, #36]
	cmp	r6, r3
	movcs	r9, ip
	ldrcs	r8, [sp, #20]
	bcs	.L25
	b	.L73
.L102:
	ldr	r3, [sp, #104]
	str	r3, [sp, #36]
	ldr	ip, [sp, #108]
	ldrd	r4, [sp, #24]
	adds	r4, r4, r6
	adc	r5, r5, #0
	ldr	r1, [sp, #32]
	add	r6, r6, r1
	mov	r1, #0
	adds	r0, ip, r9
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r9, r4
	mov	r2, r3
	adds	r0, r2, r8
	adds	r2, r0, r5
	mov	r8, r2
	ldr	r0, [sp, #36]
	cmp	r2, r0
	bhi	.L30
	mov	r2, r0
	beq	.L91
.L72:
	add	r10, r10, #1
	b	.L30
.L91:
	cmp	r4, ip
	bhi	.L30
	bne	.L72
	ldr	r1, [sp, #32]
	cmp	r6, r1
	movcs	r9, ip
	ldrcs	r8, [sp, #36]
	bcs	.L30
	b	.L72
.L103:
	ldr	r3, [sp, #116]
	str	r3, [sp, #20]
	ldr	ip, [sp, #120]
	ldr	r3, [sp, #124]
	str	r3, [sp, #36]
	mov	r2, r3
	mov	r3, #0
	adds	r4, r2, r6
	adc	r5, r3, #0
	ldr	r3, [sp, #36]
	add	r6, r6, r3
	mov	r3, #0
	adds	r2, ip, r9
	adc	r3, r3, #0
	adds	r4, r2, r5
	adc	r5, r3, r5, asr #31
	mov	r9, r4
	ldr	r2, [sp, #20]
	adds	r2, r2, r8
	adds	r0, r2, r5
	mov	r8, r0
	ldr	r2, [sp, #20]
	cmp	r0, r2
	bhi	.L33
	beq	.L92
.L71:
	add	r10, r10, #1
	b	.L33
.L92:
	cmp	r4, ip
	bhi	.L33
	bne	.L71
	ldr	r3, [sp, #36]
	cmp	r6, r3
	movcs	r9, ip
	ldrcs	r8, [sp, #20]
	bcs	.L33
	b	.L71
.L104:
	ldr	r3, [sp, #104]
	str	r3, [sp, #36]
	ldr	ip, [sp, #108]
	ldrd	r4, [sp, #24]
	adds	r4, r4, r6
	adc	r5, r5, #0
	ldr	r1, [sp, #32]
	add	r6, r6, r1
	mov	r1, #0
	adds	r0, ip, r9
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r9, r4
	mov	r2, r3
	adds	r0, r2, r8
	adds	r2, r0, r5
	mov	r8, r2
	ldr	r0, [sp, #36]
	cmp	r2, r0
	bhi	.L38
	mov	r2, r0
	beq	.L93
.L70:
	add	r10, r10, #1
	b	.L38
.L93:
	cmp	r4, ip
	bhi	.L38
	bne	.L70
	ldr	r1, [sp, #32]
	cmp	r6, r1
	movcs	r9, ip
	ldrcs	r8, [sp, #36]
	bcs	.L38
	b	.L70
.L105:
	ldr	r3, [sp, #116]
	str	r3, [sp, #20]
	ldr	ip, [sp, #120]
	ldr	r3, [sp, #124]
	str	r3, [sp, #36]
	mov	r2, r3
	mov	r3, #0
	adds	r4, r2, r6
	adc	r5, r3, #0
	ldr	r3, [sp, #36]
	add	r6, r6, r3
	mov	r3, #0
	adds	r2, ip, r9
	adc	r3, r3, #0
	adds	r4, r2, r5
	adc	r5, r3, r5, asr #31
	mov	r9, r4
	ldr	r2, [sp, #20]
	adds	r2, r2, r8
	adds	r0, r2, r5
	mov	r8, r0
	ldr	r2, [sp, #20]
	cmp	r0, r2
	bhi	.L41
	beq	.L94
.L69:
	add	r10, r10, #1
	b	.L41
.L94:
	cmp	r4, ip
	bhi	.L41
	bne	.L69
	ldr	r3, [sp, #36]
	cmp	r6, r3
	movcs	r9, ip
	ldrcs	r8, [sp, #20]
	bcs	.L41
	b	.L69
.L106:
	ldr	r3, [sp, #104]
	str	r3, [sp, #36]
	ldr	ip, [sp, #108]
	ldrd	r4, [sp, #24]
	adds	r4, r4, r6
	adc	r5, r5, #0
	ldr	r1, [sp, #32]
	add	r6, r6, r1
	mov	r1, #0
	adds	r0, ip, r9
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r9, r4
	mov	r2, r3
	adds	r0, r2, r8
	adds	r2, r0, r5
	mov	r8, r2
	ldr	r0, [sp, #36]
	cmp	r2, r0
	bhi	.L46
	mov	r2, r0
	beq	.L95
.L68:
	add	r10, r10, #1
	b	.L46
.L95:
	cmp	r4, ip
	bhi	.L46
	bne	.L68
	ldr	r1, [sp, #32]
	cmp	r6, r1
	movcs	r9, ip
	ldrcs	r8, [sp, #36]
	bcs	.L46
	b	.L68
.L107:
	ldr	r3, [sp, #116]
	str	r3, [sp, #20]
	ldr	ip, [sp, #120]
	ldr	r3, [sp, #124]
	str	r3, [sp, #36]
	mov	r2, r3
	mov	r3, #0
	adds	r4, r2, r6
	adc	r5, r3, #0
	ldr	r3, [sp, #36]
	add	r6, r6, r3
	mov	r3, #0
	adds	r2, ip, r9
	adc	r3, r3, #0
	adds	r4, r2, r5
	adc	r5, r3, r5, asr #31
	mov	r9, r4
	ldr	r2, [sp, #20]
	adds	r2, r2, r8
	adds	r0, r2, r5
	mov	r8, r0
	ldr	r2, [sp, #20]
	cmp	r0, r2
	bhi	.L49
	beq	.L96
.L67:
	add	r10, r10, #1
	b	.L49
.L96:
	cmp	r4, ip
	bhi	.L49
	bne	.L67
	ldr	r3, [sp, #36]
	cmp	r6, r3
	movcs	r9, ip
	ldrcs	r8, [sp, #20]
	bcs	.L49
	b	.L67
.L108:
	ldr	ip, [sp, #104]
	ldr	lr, [sp, #108]
	ldrd	r4, [sp, #24]
	adds	r4, r4, r6
	adc	r5, r5, #0
	ldr	r1, [sp, #32]
	add	r6, r6, r1
	mov	r1, #0
	adds	r0, lr, r3
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r3, r4
	adds	r0, ip, r8
	adds	r8, r0, r5
	cmp	r8, ip
	bhi	.L54
	beq	.L97
.L66:
	add	r10, r10, #1
	b	.L54
.L97:
	cmp	r4, lr
	bhi	.L54
	bne	.L66
	ldr	r1, [sp, #32]
	cmp	r6, r1
	movcs	r3, lr
	movcs	r8, ip
	bcs	.L54
	b	.L66
.L65:
	add	r10, r10, #1
.L57:
	lsl	r2, r3, #31
	add	r6, r2, r6, lsr #1
	lsl	r9, r8, #31
	add	r9, r9, r3, lsr #1
	lsr	r8, r8, #1
	add	r8, r8, r10, lsl #31
	lsr	r10, r10, #1
	lsr	r7, r7, #1
	ldr	r3, [sp, #16]
	add	r3, r3, #5
	str	r3, [sp, #16]
	ldr	r2, [sp, #128]
	cmp	r2, r3
	ble	.L98
.L60:
	ldr	r3, [sp, #16]
	mov	lr, r3
	tst	r3, #31
	beq	.L99
.L21:
	and	r3, r7, fp
	eor	r3, r3, r6
	and	r3, r3, #1
	str	r3, [sp, #20]
	tst	r7, #1
	bne	.L100
.L22:
	ldr	r3, [sp, #20]
	cmp	r3, #0
	bne	.L101
.L25:
	lsl	r3, r9, #31
	add	r6, r3, r6, lsr #1
	lsl	r3, r8, #31
	add	r9, r3, r9, lsr #1
	lsr	r8, r8, #1
	add	r8, r8, r10, lsl #31
	lsr	r10, r10, #1
	add	r3, lr, #1
	tst	r3, #31
	lsrne	r7, r7, #1
	ldreq	r7, [sp, #12]
	ldreq	r3, [sp, #4]
	streq	r3, [sp, #12]
	ldreq	r3, [sp, #8]
	streq	r3, [sp, #4]
	moveq	r3, #0
	streq	r3, [sp, #8]
	and	r3, r7, fp
	eor	r3, r3, r6
	and	r3, r3, #1
	str	r3, [sp, #20]
	tst	r7, #1
	bne	.L102
.L30:
	ldr	r3, [sp, #20]
	cmp	r3, #0
	bne	.L103
.L33:
	lsl	r3, r9, #31
	add	r6, r3, r6, lsr #1
	lsl	r3, r8, #31
	add	r9, r3, r9, lsr #1
	lsr	r8, r8, #1
	add	r8, r8, r10, lsl #31
	lsr	r10, r10, #1
	add	r3, lr, #2
	tst	r3, #31
	lsrne	r7, r7, #1
	ldreq	r7, [sp, #12]
	ldreq	r3, [sp, #4]
	streq	r3, [sp, #12]
	ldreq	r3, [sp, #8]
	streq	r3, [sp, #4]
	moveq	r3, #0
	streq	r3, [sp, #8]
	and	r3, r7, fp
	eor	r3, r3, r6
	and	r3, r3, #1
	str	r3, [sp, #20]
	tst	r7, #1
	bne	.L104
.L38:
	ldr	r3, [sp, #20]
	cmp	r3, #0
	bne	.L105
.L41:
	lsl	r3, r9, #31
	add	r6, r3, r6, lsr #1
	lsl	r3, r8, #31
	add	r9, r3, r9, lsr #1
	lsr	r8, r8, #1
	add	r8, r8, r10, lsl #31
	lsr	r10, r10, #1
	add	r3, lr, #3
	tst	r3, #31
	lsrne	r7, r7, #1
	ldreq	r7, [sp, #12]
	ldreq	r3, [sp, #4]
	streq	r3, [sp, #12]
	ldreq	r3, [sp, #8]
	streq	r3, [sp, #4]
	moveq	r3, #0
	streq	r3, [sp, #8]
	and	r3, r7, fp
	eor	r3, r3, r6
	and	r3, r3, #1
	str	r3, [sp, #20]
	tst	r7, #1
	bne	.L106
.L46:
	ldr	r3, [sp, #20]
	cmp	r3, #0
	bne	.L107
.L49:
	lsl	r3, r9, #31
	add	r6, r3, r6, lsr #1
	lsl	r3, r8, #31
	add	r3, r3, r9, lsr #1
	lsr	r8, r8, #1
	add	r8, r8, r10, lsl #31
	lsr	r10, r10, #1
	add	lr, lr, #4
	tst	lr, #31
	lsrne	r7, r7, #1
	ldreq	r7, [sp, #12]
	ldreq	r2, [sp, #4]
	streq	r2, [sp, #12]
	ldreq	r2, [sp, #8]
	streq	r2, [sp, #4]
	moveq	r2, #0
	streq	r2, [sp, #8]
	and	r2, r7, fp
	eor	r2, r2, r6
	and	r2, r2, #1
	tst	r7, #1
	bne	.L108
.L54:
	cmp	r2, #0
	beq	.L57
	ldr	r2, [sp, #116]
	ldr	lr, [sp, #120]
	ldr	ip, [sp, #124]
	mov	r1, #0
	adds	r4, ip, r6
	adc	r5, r1, #0
	add	r6, r6, ip
	mov	r1, #0
	adds	r0, lr, r3
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r3, r4
	adds	r0, r2, r8
	adds	r8, r0, r5
	cmp	r8, r2
	bhi	.L57
	bne	.L65
	cmp	r4, lr
	bhi	.L57
	bne	.L65
	cmp	r6, ip
	movcs	r3, lr
	movcs	r8, r2
	bcs	.L57
	b	.L65
.L98:
	tst	r10, #1
	bne	.L61
	ldr	r3, [sp, #116]
	cmp	r3, r8
	bcc	.L61
.L75:
	cmp	r8, r3
	bne	.L64
	ldr	r3, [sp, #120]
	cmp	r9, r3
	bhi	.L61
	bne	.L64
	ldr	r3, [sp, #124]
	cmp	r6, r3
	bcc	.L64
.L61:
	mov	r10, #0
	mov	fp, #1
	ldr	ip, [sp, #124]
	subs	r0, r10, ip
	sbc	r1, fp, #0
	adds	r2, r0, r6
	adc	r3, r1, #0
	mov	r6, r2
	mvn	r4, #0
	mov	r5, #0
	cmp	r3, r5
	cmpeq	r2, r4
	movls	r1, #1
	movhi	r1, #0
	mov	r0, #0
	ldr	ip, [sp, #120]
	subs	r2, r10, ip
	sbc	r3, fp, #0
	adds	r10, r2, r9
	adc	fp, r3, #0
	subs	r3, r10, r1
	str	r3, [sp, #40]
	sbc	r3, fp, r0
	str	r3, [sp, #44]
	ldrd	r2, [sp, #40]
	mov	r9, r2
	cmp	r3, r5
	cmpeq	r2, r4
	movls	r2, #1
	movhi	r2, r0
	ldr	r3, [sp, #116]
	sub	r8, r8, r3
	sub	r8, r8, r2
.L64:
	ldr	r3, [sp, #48]
	str	r8, [r3]
	str	r9, [r3, #4]
	str	r6, [r3, #8]
	mov	r0, r3
	add	sp, sp, #68
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L20:
	ldr	r3, [sp, #116]
	mov	r9, #0
	mov	r6, r9
	mov	r8, r9
	b	.L75
	.size	modular_multiplication_32x3, .-modular_multiplication_32x3
	.align	2
	.global	modular_exponentiation_mont_32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	modular_exponentiation_mont_32x3, %function
modular_exponentiation_mont_32x3:
	@ args = 40, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #100
	mov	ip, r0
	str	r0, [sp, #36]
	add	r7, sp, #60
	stm	r7, {r1, r2, r3}
	ldr	fp, [sp, #160]
	ldr	r10, [sp, #136]
	ldr	r9, [sp, #140]
	ldr	r8, [sp, #144]
	mov	r3, #0
	str	r3, [sp, #84]
	str	r3, [sp, #88]
	mov	r3, #1
	str	r3, [sp, #92]
	str	fp, [sp, #24]
	add	r5, sp, #12
	add	r6, sp, #148
	ldm	r6, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	add	r4, sp, #164
	ldm	r4, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	add	r3, sp, #96
	ldmdb	r3, {r1, r2, r3}
	mov	r0, ip
	bl	modular_multiplication_32x3
	str	fp, [sp, #24]
	ldm	r6, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	ldm	r4, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	r7, {r1, r2, r3}
	add	r0, sp, #72
	bl	modular_multiplication_32x3
	add	r5, sp, #40
	add	r7, sp, #12
	add	r6, sp, #148
	b	.L110
.L112:
	tst	r8, #1
	beq	.L111
	str	fp, [sp, #24]
	ldm	r6, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r3, sp, #72
	ldm	r3, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldr	r4, [sp, #36]
	ldm	r4, {r1, r2, r3}
	mov	r0, r5
	bl	modular_multiplication_32x3
	ldm	r5, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
.L111:
	lsl	r3, r9, #31
	add	r8, r3, r8, lsr #1
	lsl	r3, r10, #31
	add	r9, r3, r9, lsr #1
	lsr	r10, r10, #1
	str	fp, [sp, #24]
	ldm	r6, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r4, sp, #72
	ldm	r4, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	r4, {r1, r2, r3}
	mov	r0, r5
	bl	modular_multiplication_32x3
	ldm	r5, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
.L110:
	cmp	r8, #0
	bne	.L112
	orrs	r3, r9, r10
	bne	.L111
	add	r4, sp, #40
	str	fp, [sp, #24]
	add	r3, sp, #12
	add	r2, sp, #148
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	add	r3, sp, #96
	ldmdb	r3, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldr	r5, [sp, #36]
	ldm	r5, {r1, r2, r3}
	mov	r0, r4
	bl	modular_multiplication_32x3
	ldm	r4, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	mov	r0, r5
	add	sp, sp, #100
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	modular_exponentiation_mont_32x3, .-modular_exponentiation_mont_32x3
	.align	2
	.global	encrypt
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	encrypt, %function
encrypt:
	@ args = 40, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #56
	mov	r4, r0
	add	ip, sp, #44
	stm	ip, {r1, r2, r3}
	add	r3, sp, #28
	add	r2, sp, #92
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	ldr	r3, [sp, #88]
	str	r3, [sp, #24]
	add	r3, sp, #12
	add	r2, sp, #76
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	add	r3, sp, #60
	ldmib	r3, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	ip, {r1, r2, r3}
	mov	r0, r4
	bl	modular_exponentiation_mont_32x3
	mov	r0, r4
	add	sp, sp, #56
	@ sp needed
	pop	{r4, pc}
	.size	encrypt, .-encrypt
	.align	2
	.global	decrypt
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	decrypt, %function
decrypt:
	@ args = 40, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #56
	mov	r4, r0
	add	ip, sp, #44
	stm	ip, {r1, r2, r3}
	add	r3, sp, #28
	add	r2, sp, #92
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	ldr	r3, [sp, #88]
	str	r3, [sp, #24]
	add	r3, sp, #12
	add	r2, sp, #76
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	add	r3, sp, #60
	ldmib	r3, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	ip, {r1, r2, r3}
	mov	r0, r4
	bl	modular_exponentiation_mont_32x3
	mov	r0, r4
	add	sp, sp, #56
	@ sp needed
	pop	{r4, pc}
	.size	decrypt, .-decrypt
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 392
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	vpush.64	{d8}
	sub	sp, sp, #436
	mov	r3, #10
	str	r3, [sp, #104]
	mov	r3, #0
	str	r3, [sp, #92]
	movw	r3, #13706
	movt	r3, 14308
	str	r3, [sp, #56]
	movw	r3, #11765
	movt	r3, 31010
	str	r3, [sp, #124]
	movw	r3, #26691
	movt	r3, 29870
	str	r3, [sp, #128]
	movw	r3, #17499
	movt	r3, 51872
	str	r3, [sp, #132]
	movw	r3, #24841
	movt	r3, 48821
	str	r3, [sp, #136]
	movw	r3, #21836
	movt	r3, 16059
	str	r3, [sp, #140]
.L119:
	movw	r6, #:lower16:.LANCHOR0
	movt	r6, #:upper16:.LANCHOR0
	add	r5, sp, #144
	ldm	r6, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	add	r8, sp, #156
	add	r3, r6, #12
	ldm	r3, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r4, sp, #168
	add	r3, r6, #24
	ldm	r3, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	add	r3, r6, #36
	ldm	r3, {r0, r1, r2}
	add	r3, sp, #180
	stm	r3, {r0, r1, r2}
	add	r10, sp, #192
	add	r3, r6, #48
	ldm	r3, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	movw	r0, #:lower16:.LC11
	movt	r0, #:upper16:.LC11
	bl	puts
	movw	r3, #:lower16:.LC12
	movt	r3, #:upper16:.LC12
	str	r3, [sp, #60]
	mov	r0, r3
	bl	puts
	movw	r2, #10479
	movt	r2, 690
	movw	r1, #:lower16:.LC13
	movt	r1, #:upper16:.LC13
	movw	r0, #:lower16:.LC10
	movt	r0, #:upper16:.LC10
	mov	r7, r0
	movw	ip, #51339
	movt	ip, 49146
	str	ip, [sp, #72]
	str	ip, [sp]
	str	r2, [sp, #64]
	mov	r3, r2
	ldr	r2, [sp, #56]
	str	r1, [sp, #68]
	bl	printf
	movw	r0, #:lower16:.LC14
	movt	r0, #:upper16:.LC14
	ldr	lr, [sp, #132]
	str	lr, [sp]
	ldr	r3, [sp, #124]
	ldr	r2, [sp, #128]
	str	r0, [sp, #76]
	mov	r1, r0
	mov	r0, r7
	bl	printf
	movw	lr, #:lower16:.LC15
	movt	lr, #:upper16:.LC15
	movw	r3, #11103
	movt	r3, 11019
	str	r3, [sp]
	ldr	r3, [sp, #136]
	ldr	r2, [sp, #140]
	str	lr, [sp, #80]
	mov	r1, lr
	mov	r0, r7
	bl	printf
	movw	r9, #:lower16:.LC16
	movt	r9, #:upper16:.LC16
	movw	r3, #1823
	movt	r3, 31279
	str	r3, [sp]
	movw	r3, #3379
	movt	r3, 41318
	movw	r2, #19192
	movt	r2, 30358
	str	r9, [sp, #84]
	mov	r1, r9
	str	r7, [sp, #40]
	mov	r0, r7
	bl	printf
	movw	fp, #:lower16:.LC17
	movt	fp, #:upper16:.LC17
	str	fp, [sp, #88]
	mov	r0, fp
	bl	puts
	bl	clock
	mov	r7, r0
	add	fp, sp, #384
	ldm	r5, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	add	r9, sp, #396
	ldm	r4, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	add	r4, sp, #408
	ldm	r8, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	add	r5, sp, #420
	ldm	r10, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	add	r3, sp, #28
	str	r3, [sp, #44]
	stm	r3, {r0, r1, r2}
	mov	r2, #95
	str	r2, [sp, #24]
	add	r1, sp, #12
	mov	lr, r1
	ldm	r4, {r0, r1, r2}
	str	lr, [sp, #48]
	stm	lr, {r0, r1, r2}
	ldm	r9, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #204
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r7, r0, r7
	ldr	r1, [sp, #92]
	add	r1, r7, r1
	str	r1, [sp, #100]
	movw	r1, #:lower16:.LC18
	movt	r1, #:upper16:.LC18
	ldr	r3, [sp, #212]
	str	r3, [sp]
	ldr	r3, [sp, #208]
	ldr	r2, [sp, #204]
	str	r1, [sp, #92]
	ldr	r0, [sp, #40]
	bl	printf
	vmov	s15, r7	@ int
	vcvt.f64.s32	d7, s15
	vldr.64	d8, .L122
	movw	r1, #:lower16:.LC19
	movt	r1, #:upper16:.LC19
	str	r7, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	str	r1, [sp, #52]
	mov	r0, r1
	bl	printf
	movw	r7, #:lower16:.LC20
	movt	r7, #:upper16:.LC20
	str	r7, [sp, #96]
	mov	r0, r7
	bl	puts
	bl	clock
	mov	r7, r0
	add	r0, sp, #204
	ldm	r0, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	add	r0, sp, #180
	ldm	r0, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	ldm	r10, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	ldr	r3, [sp, #44]
	stm	r3, {r0, r1, r2}
	mov	r2, #95
	str	r2, [sp, #24]
	ldm	r4, {r0, r1, r2}
	ldr	r8, [sp, #48]
	stm	r8, {r0, r1, r2}
	ldm	r9, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #216
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r7
	ldr	r10, [sp, #100]
	add	r10, r10, r0
	str	r10, [sp, #108]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	ldr	r0, [sp, #52]
	bl	printf
	movw	r10, #:lower16:.LC21
	movt	r10, #:upper16:.LC21
	ldr	r3, [sp, #224]
	str	r3, [sp]
	ldr	r3, [sp, #220]
	ldr	r2, [sp, #216]
	str	r10, [sp, #100]
	mov	r1, r10
	ldr	r10, [sp, #40]
	mov	r0, r10
	bl	printf
	mov	r0, #10
	bl	putchar
	ldm	r6, {r0, r1, r2}
	add	r7, sp, #228
	stm	r7, {r0, r1, r2}
	add	r0, r6, #60
	ldm	r0, {r0, r1, r2}
	add	r7, sp, #240
	stm	r7, {r0, r1, r2}
	add	r8, sp, #252
	add	r3, r6, #72
	ldm	r3, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r3, r6, #84
	ldm	r3, {r0, r1, r2}
	add	r7, sp, #264
	stm	r7, {r0, r1, r2}
	add	r7, sp, #276
	add	r2, r3, #12
	ldm	r2, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	movw	r0, #:lower16:.LC22
	movt	r0, #:upper16:.LC22
	bl	puts
	ldr	r0, [sp, #60]
	bl	puts
	ldr	ip, [sp, #72]
	str	ip, [sp]
	ldr	r3, [sp, #64]
	ldr	r2, [sp, #56]
	ldr	r1, [sp, #68]
	str	r10, [sp, #40]
	mov	r0, r10
	bl	printf
	movw	r0, #623
	movt	r0, 30588
	movw	r2, #15898
	movt	r2, 17858
	movw	r10, #41985
	movt	r10, 42782
	str	r10, [sp]
	str	r0, [sp, #116]
	mov	r3, r0
	str	r2, [sp, #120]
	ldr	r1, [sp, #76]
	ldr	r0, [sp, #40]
	bl	printf
	movw	r3, #45589
	movt	r3, 61504
	str	r3, [sp]
	movw	r3, #27703
	movt	r3, 41230
	movw	r2, #24961
	movt	r2, 10056
	ldr	r1, [sp, #80]
	ldr	r0, [sp, #40]
	bl	printf
	movw	r3, #17233
	movt	r3, 43944
	str	r3, [sp]
	movw	r3, #18682
	movt	r3, 21659
	movw	r2, #8029
	movt	r2, 51045
	ldr	r1, [sp, #84]
	ldr	r0, [sp, #40]
	bl	printf
	ldr	r0, [sp, #88]
	bl	puts
	bl	clock
	str	r0, [sp, #112]
	add	ip, sp, #228
	ldm	ip, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	add	r8, sp, #240
	ldm	r8, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	ldm	r7, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	ldr	ip, [sp, #44]
	stm	ip, {r0, r1, r2}
	mov	lr, #95
	str	lr, [sp, #24]
	ldm	r4, {r0, r1, r2}
	ldr	r8, [sp, #48]
	stm	r8, {r0, r1, r2}
	ldm	r9, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r8, sp, #288
	mov	r0, r8
	bl	modular_exponentiation_mont_32x3
	bl	clock
	ldr	r8, [sp, #112]
	sub	r8, r0, r8
	ldr	r3, [sp, #108]
	add	r3, r3, r8
	str	r3, [sp, #108]
	ldr	r3, [sp, #296]
	str	r3, [sp]
	ldr	r3, [sp, #292]
	ldr	r2, [sp, #288]
	ldr	r1, [sp, #92]
	ldr	r0, [sp, #40]
	bl	printf
	vmov	s15, r8	@ int
	vcvt.f64.s32	d7, s15
	str	r8, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	ldr	r0, [sp, #52]
	bl	printf
	ldr	r0, [sp, #96]
	bl	puts
	bl	clock
	mov	r8, r0
	add	r2, sp, #288
	ldm	r2, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	add	r2, sp, #264
	ldm	r2, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	add	r2, sp, #240
	ldm	r2, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	ldm	r7, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	ldr	ip, [sp, #44]
	stm	ip, {r0, r1, r2}
	mov	lr, #95
	str	lr, [sp, #24]
	ldm	r4, {r0, r1, r2}
	ldr	r7, [sp, #48]
	stm	r7, {r0, r1, r2}
	ldm	r9, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #300
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r8
	ldr	r8, [sp, #108]
	add	r8, r8, r0
	str	r8, [sp, #108]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	ldr	r0, [sp, #52]
	bl	printf
	ldr	r3, [sp, #308]
	str	r3, [sp]
	ldr	r3, [sp, #304]
	ldr	r2, [sp, #300]
	ldr	r1, [sp, #100]
	ldr	r0, [sp, #40]
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r8, sp, #312
	ldm	r6, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r7, sp, #324
	add	lr, r6, #60
	ldm	lr, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r6, r6, #108
	ldm	r6, {r0, r1, r2}
	add	r6, sp, #336
	stm	r6, {r0, r1, r2}
	add	r6, sp, #348
	add	lr, lr, #36
	ldm	lr, {r0, r1, r2}
	stm	r6, {r0, r1, r2}
	movw	r0, #:lower16:.LC23
	movt	r0, #:upper16:.LC23
	bl	puts
	ldr	r0, [sp, #60]
	bl	puts
	ldr	ip, [sp, #72]
	str	ip, [sp]
	ldr	r3, [sp, #64]
	ldr	r2, [sp, #56]
	ldr	r1, [sp, #68]
	ldr	r0, [sp, #40]
	bl	printf
	str	r10, [sp]
	ldr	r3, [sp, #116]
	ldr	r2, [sp, #120]
	b	.L123
.L124:
	.align	3
.L122:
	.word	0
	.word	1093567616
.L123:
	ldr	r1, [sp, #76]
	ldr	r10, [sp, #40]
	mov	r0, r10
	bl	printf
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp]
	mov	r3, #0
	mov	r2, r3
	ldr	r1, [sp, #80]
	mov	r0, r10
	bl	printf
	movw	r3, #47657
	movt	r3, 63748
	str	r3, [sp]
	movw	r3, #33530
	movt	r3, 35614
	movw	r2, #2692
	movt	r2, 28575
	ldr	r1, [sp, #84]
	str	r10, [sp, #40]
	mov	r0, r10
	bl	printf
	ldr	r0, [sp, #88]
	bl	puts
	bl	clock
	str	r0, [sp, #60]
	ldm	r8, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	mov	r3, #0
	str	r3, [sp, #396]
	str	r3, [sp, #400]
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp, #404]
	ldm	r7, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	ldm	r6, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	add	r10, sp, #360
	ldr	ip, [sp, #44]
	stm	ip, {r0, r1, r2}
	mov	lr, #95
	str	lr, [sp, #24]
	ldm	r4, {r0, r1, r2}
	ldr	r8, [sp, #48]
	stm	r8, {r0, r1, r2}
	ldm	r9, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	mov	r0, r10
	bl	modular_exponentiation_mont_32x3
	bl	clock
	ldr	r3, [sp, #60]
	sub	r8, r0, r3
	ldr	r2, [sp, #108]
	add	r2, r2, r8
	str	r2, [sp, #60]
	ldr	r3, [sp, #368]
	str	r3, [sp]
	ldr	r3, [sp, #364]
	ldr	r2, [sp, #360]
	ldr	r1, [sp, #92]
	ldr	r0, [sp, #40]
	bl	printf
	vmov	s15, r8	@ int
	vcvt.f64.s32	d7, s15
	str	r8, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	ldr	r0, [sp, #52]
	bl	printf
	ldr	r0, [sp, #96]
	bl	puts
	bl	clock
	mov	r8, r0
	ldm	r10, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	add	r3, sp, #336
	ldm	r3, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldm	r7, {r0, r1, r2}
	stm	r4, {r0, r1, r2}
	ldm	r6, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	ldr	ip, [sp, #44]
	stm	ip, {r0, r1, r2}
	mov	lr, #95
	str	lr, [sp, #24]
	ldm	r4, {r0, r1, r2}
	ldr	r7, [sp, #48]
	stm	r7, {r0, r1, r2}
	ldm	r9, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #372
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r8
	ldr	r2, [sp, #60]
	add	r3, r2, r0
	str	r3, [sp, #92]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	ldr	r0, [sp, #52]
	bl	printf
	ldr	r3, [sp, #380]
	str	r3, [sp]
	ldr	r3, [sp, #376]
	ldr	r2, [sp, #372]
	ldr	r1, [sp, #100]
	ldr	r0, [sp, #40]
	bl	printf
	mov	r0, #10
	bl	putchar
	ldr	r3, [sp, #104]
	subs	r3, r3, #1
	str	r3, [sp, #104]
	bne	.L119
	movw	r0, #:lower16:.LC12
	movt	r0, #:upper16:.LC12
	bl	puts
	vldr.32	s15, [sp, #92]	@ int
	vcvt.f64.s32	d6, s15
	vstr.32	s15, [sp]	@ int
	vdiv.f64	d7, d6, d8
	vmov	r2, r3, d7
	movw	r0, #:lower16:.LC24
	movt	r0, #:upper16:.LC24
	bl	printf
	mov	r0, #0
	add	sp, sp, #436
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
.LC0:
	.word	937702794
	.word	45230319
	.word	-1074083701
.LC1:
	.word	1957587011
	.word	2032283125
	.word	-895466405
.LC2:
	.word	1052464460
	.word	-1095409399
	.word	722152287
.LC3:
	.word	1989561080
	.word	-1587147469
	.word	2049902367
.LC4:
	.word	1714386002
	.word	-223213644
	.word	-552269267
.LC5:
	.word	1170357786
	.word	2004615791
	.word	-1491164159
.LC6:
	.word	659054977
	.word	-1592890313
	.word	-264195563
.LC7:
	.word	-949674147
	.word	1419462906
	.word	-1415036079
.LC8:
	.word	40048680
	.word	-764841694
	.word	62299219
.LC9:
	.word	1872693892
	.word	-1960934662
	.word	-117130711
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC10:
	.ascii	"%s = %08x%08x%08x\015\012\000"
.LC11:
	.ascii	"Perfoming Test 2 - 95 bit keys\000"
	.space	1
.LC12:
	.ascii	"----------------------\000"
	.space	1
.LC13:
	.ascii	"Plain Text\000"
	.space	1
.LC14:
	.ascii	"PQ\000"
	.space	1
.LC15:
	.ascii	"E\000"
	.space	2
.LC16:
	.ascii	"D\000"
	.space	2
.LC17:
	.ascii	"Encrypting 95 bit...\000"
	.space	3
.LC18:
	.ascii	"Encrypted Cipher Text\000"
	.space	2
.LC19:
	.ascii	"Time taken = %fs, Clock Cycles = %ld\012\000"
	.space	2
.LC20:
	.ascii	"Decrypting 95 bit...\000"
	.space	3
.LC21:
	.ascii	"Decrypted Plain Text\000"
	.space	3
.LC22:
	.ascii	"Perfoming Test 3 - 95 bit keys\000"
	.space	1
.LC23:
	.ascii	"Perfoming Test 4 - 95 bit keys\000"
	.space	1
.LC24:
	.ascii	"Total Time taken = %fs, Clock Cycles = %ld\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
