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
	.file	"montgomery_96bit_optimized_v2neon.c"
	.text
	.align	2
	.global	add_uint96
	.arch armv7-a
	.syntax unified
	.arm
	.fpu neon
	.type	add_uint96, %function
add_uint96:
	@ args = 12, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #48
	add	ip, sp, #4
	stm	ip, {r1, r2, r3}
	ldr	lr, [sp, #8]
	ldr	ip, [sp, #12]
	ldr	r4, [sp, #60]
	str	ip, [sp, #32]
	str	lr, [sp, #36]
	str	r1, [sp, #40]
	mov	r3, #0
	str	r3, [sp, #44]
	ldr	r2, [sp, #64]
	str	r2, [sp, #16]
	str	r4, [sp, #20]
	ldr	r2, [sp, #56]
	str	r2, [sp, #24]
	str	r3, [sp, #28]
	add	r3, sp, #32
	vld1.32	{d18-d19}, [r3:64]
	add	r3, sp, #16
	vld1.32	{d16-d17}, [r3:64]
	vadd.i32	q8, q8, q9
	vmov.32	r1, d17[0]
	vmov.32	r2, d16[1]
	vmov.32	r3, d16[0]
	cmp	ip, r3
	bls	.L2
	add	r2, r2, #1
	cmp	r2, r4
	addls	r1, r1, #1
.L3:
	str	r1, [r0]
	str	r2, [r0, #4]
	str	r3, [r0, #8]
	add	sp, sp, #48
	@ sp needed
	pop	{r4, pc}
.L2:
	cmp	r2, lr
	addcc	r1, r1, #1
	b	.L3
	.size	add_uint96, .-add_uint96
	.align	2
	.global	sub_uint96
	.syntax unified
	.arm
	.fpu neon
	.type	sub_uint96, %function
sub_uint96:
	@ args = 12, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #20
	mov	ip, r0
	add	lr, sp, #16
	stmdb	lr, {r1, r2, r3}
	ldr	r6, [sp, #12]
	mov	r3, #0
	adds	r6, r6, #0
	adc	r7, r3, #1
	ldr	r3, [sp, #64]
	subs	r10, r6, r3
	sbc	fp, r7, #0
	mvn	r2, #0
	mov	r3, #0
	cmp	fp, r3
	cmpeq	r10, r2
	mov	r1, #0
	movls	r8, #1
	movhi	r8, r1
	mov	r9, r1
	ldr	r4, [sp, #8]
	mov	r5, #0
	adds	r6, r4, #0
	adc	r7, r5, #1
	ldr	lr, [sp, #60]
	subs	r4, r6, lr
	sbc	r5, r7, #0
	subs	r4, r4, r8
	sbc	r5, r5, r9
	mov	r6, r4
	cmp	r5, r3
	cmpeq	r4, r2
	movls	r4, #1
	movhi	r4, r1
	mov	r5, r1
	ldr	r2, [sp, #4]
	mov	r3, #0
	adds	r8, r2, #0
	adc	r9, r3, #1
	ldr	r1, [sp, #56]
	subs	r2, r8, r1
	sbc	r3, r9, #0
	subs	r2, r2, r4
	sbc	r3, r3, r5
	str	r2, [ip]
	str	r6, [r0, #4]
	str	r10, [r0, #8]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	sub_uint96, .-sub_uint96
	.align	2
	.global	cmp_uint96
	.syntax unified
	.arm
	.fpu neon
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
	bhi	.L7
	movne	r0, #1
	beq	.L14
.L7:
	add	sp, sp, #16
	@ sp needed
	add	sp, sp, #8
	bx	lr
.L14:
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #24]
	cmp	r2, r3
	movcc	r0, #0
	bcc	.L7
	movne	r0, #1
	bne	.L7
	ldr	r0, [sp, #12]
	ldr	r3, [sp, #28]
	cmp	r0, r3
	movcs	r0, #0
	movcc	r0, #1
	b	.L7
	.size	cmp_uint96, .-cmp_uint96
	.align	2
	.global	rshift_uint96
	.syntax unified
	.arm
	.fpu neon
	.type	rshift_uint96, %function
rshift_uint96:
	@ args = 4, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #16
	add	ip, sp, #16
	stmdb	ip, {r1, r2, r3}
	ldr	r3, [sp, #24]
	ldr	r2, [sp, #4]
	cmp	r3, #63
	bgt	.L20
	ldr	r1, [sp, #8]
	cmp	r3, #31
	bgt	.L21
	rsb	lr, r3, #32
	lsl	ip, r1, lr
	ldr	r4, [sp, #12]
	add	ip, ip, r4, lsr r3
	lsr	r4, r2, r3
	str	r4, [r0]
	lsl	r2, r2, lr
	add	r3, r2, r1, lsr r3
	str	r3, [r0, #4]
	str	ip, [r0, #8]
.L15:
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
.L20:
	mov	r1, #0
	str	r1, [r0]
	str	r1, [r0, #4]
	sub	r3, r3, #64
	lsr	r3, r2, r3
	str	r3, [r0, #8]
	b	.L15
.L21:
	sub	r3, r3, #32
	mov	ip, #0
	str	ip, [r0]
	lsr	ip, r2, r3
	str	ip, [r0, #4]
	rsb	ip, r3, #32
	lsr	r3, r1, r3
	add	r3, r3, r2, lsl ip
	str	r3, [r0, #8]
	b	.L15
	.size	rshift_uint96, .-rshift_uint96
	.align	2
	.global	print_uint96
	.syntax unified
	.arm
	.fpu neon
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
	movw	r0, #:lower16:.LC17
	movt	r0, #:upper16:.LC17
	bl	printf
	add	sp, sp, #28
	@ sp needed
	ldr	pc, [sp], #4
	.size	print_uint96, .-print_uint96
	.align	2
	.global	modular_multiplication_32x3
	.syntax unified
	.arm
	.fpu neon
	.type	modular_multiplication_32x3, %function
modular_multiplication_32x3:
	@ args = 28, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #84
	str	r0, [sp, #28]
	add	r0, sp, #52
	stm	r0, {r1, r2, r3}
	ldr	r10, [sp, #144]
	str	r1, [sp, #24]
	ldr	r3, [sp, #56]
	str	r3, [sp, #20]
	ldr	r3, [sp, #60]
	str	r3, [sp, #16]
	ldr	fp, [sp, #128]
	cmp	r10, #0
	ble	.L25
	and	r9, fp, #1
	mov	r2, #0
	mov	ip, r2
	mov	r3, r2
	mov	r6, r2
	mov	r7, r2
	add	r8, sp, #68
	b	.L33
.L46:
	ldr	r5, [sp, #16]
	ldr	r1, [sp, #20]
	str	r1, [sp, #16]
	ldr	r1, [sp, #24]
	str	r1, [sp, #20]
	mov	r1, #0
	str	r1, [sp, #24]
	b	.L26
.L47:
	str	r3, [sp, #68]
	str	r2, [sp, #72]
	str	ip, [sp, #76]
	str	fp, [sp, #128]
	add	r3, sp, #120
	ldm	r3, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	r8, {r1, r2, r3}
	mov	r0, r8
	bl	add_uint96
	ldr	r3, [sp, #68]
	ldr	r2, [sp, #72]
	ldr	ip, [sp, #76]
	ldr	r1, [sp, #120]
	cmp	r3, r1
	bhi	.L27
	beq	.L44
.L39:
	add	r7, r7, #1
	b	.L27
.L44:
	ldr	r1, [sp, #124]
	cmp	r2, r1
	bhi	.L27
	bne	.L39
	cmp	fp, ip
	bls	.L27
	b	.L39
.L38:
	add	r7, r7, #1
.L30:
	lsl	r1, r2, #31
	add	ip, r1, ip, lsr #1
	lsl	r1, r3, #31
	add	r2, r1, r2, lsr #1
	lsr	r3, r3, #1
	add	r3, r3, r7, lsl #31
	lsr	r7, r7, #1
	lsr	r5, r5, #1
	add	r6, r6, #1
	cmp	r10, r6
	beq	.L45
.L33:
	tst	r6, #31
	beq	.L46
.L26:
	and	r4, r5, r9
	eor	r4, r4, ip
	and	r4, r4, #1
	tst	r5, #1
	bne	.L47
.L27:
	cmp	r4, #0
	beq	.L30
	str	r3, [sp, #68]
	str	r2, [sp, #72]
	str	ip, [sp, #76]
	add	r4, sp, #32
	add	r3, sp, #132
	ldm	r3, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	r8, {r1, r2, r3}
	mov	r0, r4
	bl	add_uint96
	ldm	r4, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	ldr	r3, [sp, #68]
	ldr	r2, [sp, #72]
	ldr	ip, [sp, #76]
	ldr	r1, [sp, #132]
	cmp	r3, r1
	bhi	.L30
	bne	.L38
	ldr	r1, [sp, #136]
	cmp	r2, r1
	bhi	.L30
	bne	.L38
	ldr	r1, [sp, #140]
	cmp	ip, r1
	bcs	.L30
	b	.L38
.L45:
	tst	r7, #1
	bne	.L34
	ldr	r1, [sp, #132]
	cmp	r3, r1
	bhi	.L34
.L40:
	cmp	r1, r3
	bne	.L37
	ldr	r1, [sp, #136]
	cmp	r2, r1
	bhi	.L34
	bne	.L37
	ldr	r1, [sp, #140]
	cmp	r1, ip
	bhi	.L37
.L34:
	mov	r0, #0
	mov	r1, #1
	ldr	lr, [sp, #140]
	subs	r4, r0, lr
	sbc	r5, r1, #0
	adds	r8, r4, ip
	adc	r9, r5, #0
	mov	ip, r8
	mvn	r6, #0
	mov	r7, #0
	cmp	r9, r7
	cmpeq	r8, r6
	movls	r8, #1
	movhi	r8, #0
	mov	r9, #0
	ldr	lr, [sp, #136]
	subs	r4, r0, lr
	sbc	r5, r1, #0
	adds	r0, r4, r2
	adc	r1, r5, #0
	subs	r0, r0, r8
	sbc	r1, r1, r9
	mov	r2, r0
	cmp	r1, r7
	cmpeq	r0, r6
	movls	r0, #1
	movhi	r0, r9
	ldr	r1, [sp, #132]
	sub	r3, r3, r1
	sub	r3, r3, r0
.L37:
	ldr	r1, [sp, #28]
	str	r3, [r1]
	str	r2, [r1, #4]
	str	ip, [r1, #8]
	mov	r0, r1
	add	sp, sp, #84
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L25:
	ldr	r1, [sp, #132]
	mov	r3, #0
	mov	r2, r3
	mov	ip, r3
	b	.L40
	.size	modular_multiplication_32x3, .-modular_multiplication_32x3
	.align	2
	.global	modular_exponentiation_mont_32x3
	.syntax unified
	.arm
	.fpu neon
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
	b	.L49
.L51:
	tst	r8, #1
	beq	.L50
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
.L50:
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
.L49:
	cmp	r8, #0
	bne	.L51
	orrs	r3, r9, r10
	bne	.L50
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
	.fpu neon
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
	.fpu neon
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
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 520
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	vpush.64	{d8}
	sub	sp, sp, #564
	movw	r4, #:lower16:.LANCHOR0
	movt	r4, #:upper16:.LANCHOR0
	add	r8, sp, #548
	ldm	r4, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r6, sp, #536
	add	r3, r4, #12
	ldm	r3, {r0, r1, r2}
	stm	r6, {r0, r1, r2}
	add	r7, sp, #524
	add	r3, r4, #24
	ldm	r3, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r5, sp, #512
	add	r3, r4, #36
	ldm	r3, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	movw	r0, #:lower16:.LC18
	movt	r0, #:upper16:.LC18
	bl	puts
	movw	r3, #:lower16:.LC19
	movt	r3, #:upper16:.LC19
	str	r3, [sp, #60]
	mov	r0, r3
	bl	puts
	movw	r1, #:lower16:.LC20
	movt	r1, #:upper16:.LC20
	movw	r9, #:lower16:.LC17
	movt	r9, #:upper16:.LC17
	mov	r3, #1
	movt	r3, 29440
	str	r3, [sp]
	mov	r3, #20480
	mov	r2, #0
	str	r1, [sp, #64]
	mov	r0, r9
	bl	printf
	movw	r2, #:lower16:.LC21
	movt	r2, #:upper16:.LC21
	mov	r0, r2
	movw	r3, #16869
	movt	r3, 64639
	str	r3, [sp]
	movw	r3, #41826
	mov	r2, #0
	str	r0, [sp, #68]
	mov	r1, r0
	mov	r0, r9
	bl	printf
	movw	ip, #:lower16:.LC22
	movt	ip, #:upper16:.LC22
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp]
	mov	r3, #0
	mov	r2, r3
	str	ip, [sp, #72]
	mov	r1, ip
	mov	r0, r9
	bl	printf
	movw	lr, #:lower16:.LC23
	movt	lr, #:upper16:.LC23
	movw	r3, #39149
	movt	r3, 13911
	str	r3, [sp]
	movw	r3, #7608
	mov	r2, #0
	str	lr, [sp, #76]
	mov	r1, lr
	str	r9, [sp, #44]
	mov	r0, r9
	bl	printf
	movw	r0, #:lower16:.LC24
	movt	r0, #:upper16:.LC24
	bl	puts
	bl	clock
	str	r0, [sp, #56]
	add	fp, sp, #128
	ldm	r8, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	mov	r8, #0
	str	r8, [sp, #140]
	str	r8, [sp, #144]
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp, #148]
	add	r10, sp, #152
	ldm	r6, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	add	r9, sp, #164
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	add	r3, sp, #28
	str	r3, [sp, #48]
	stm	r3, {r0, r1, r2}
	mov	r2, #48
	str	r2, [sp, #24]
	add	r2, sp, #12
	mov	lr, r2
	ldm	r10, {r0, r1, r2}
	str	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	add	r8, sp, #140
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #500
	bl	modular_exponentiation_mont_32x3
	bl	clock
	ldr	r1, [sp, #56]
	sub	r1, r0, r1
	str	r1, [sp, #84]
	vmov	s15, r1	@ int
	vcvt.f64.s32	d16, s15
	vldr.64	d8, .L59
	movw	r1, #:lower16:.LC25
	movt	r1, #:upper16:.LC25
	vstr.32	s15, [sp]	@ int
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	str	r1, [sp, #56]
	mov	r0, r1
	bl	printf
	movw	r0, #:lower16:.LC26
	movt	r0, #:upper16:.LC26
	ldr	r3, [sp, #508]
	str	r3, [sp]
	ldr	r3, [sp, #504]
	ldr	r2, [sp, #500]
	str	r0, [sp, #80]
	mov	r1, r0
	ldr	r0, [sp, #44]
	bl	printf
	movw	r0, #:lower16:.LC27
	movt	r0, #:upper16:.LC27
	bl	puts
	bl	clock
	str	r0, [sp, #88]
	add	ip, sp, #500
	ldm	ip, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	ldm	r7, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	ldm	r6, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldr	r3, [sp, #48]
	stm	r3, {r0, r1, r2}
	mov	r5, #48
	str	r5, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #488
	bl	modular_exponentiation_mont_32x3
	bl	clock
	ldr	r6, [sp, #88]
	sub	r0, r0, r6
	ldr	r5, [sp, #84]
	add	r5, r5, r0
	str	r5, [sp, #104]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d16, s15
	str	r0, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	movw	r5, #:lower16:.LC28
	movt	r5, #:upper16:.LC28
	ldr	r3, [sp, #496]
	str	r3, [sp]
	ldr	r3, [sp, #492]
	ldr	r2, [sp, #488]
	str	r5, [sp, #84]
	mov	r1, r5
	ldr	r0, [sp, #44]
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r7, sp, #476
	add	r6, r4, #48
	ldm	r6, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r3, r4, #60
	ldm	r3, {r0, r1, r2}
	add	ip, sp, #464
	stm	ip, {r0, r1, r2}
	add	r6, sp, #452
	add	r3, r4, #72
	ldm	r3, {r0, r1, r2}
	stm	r6, {r0, r1, r2}
	add	r3, r4, #84
	ldm	r3, {r0, r1, r2}
	add	ip, sp, #440
	stm	ip, {r0, r1, r2}
	add	r5, sp, #428
	add	r3, r4, #96
	ldm	r3, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	movw	r0, #:lower16:.LC29
	movt	r0, #:upper16:.LC29
	bl	puts
	ldr	r0, [sp, #60]
	bl	puts
	movw	r2, #10479
	movt	r2, 690
	movw	r1, #13706
	movt	r1, 14308
	movw	ip, #51339
	movt	ip, 49146
	str	ip, [sp, #96]
	str	ip, [sp]
	str	r2, [sp, #88]
	mov	r3, r2
	str	r1, [sp, #92]
	mov	r2, r1
	ldr	r1, [sp, #64]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r3, #17499
	movt	r3, 51872
	str	r3, [sp]
	movw	r3, #11765
	movt	r3, 31010
	movw	r2, #26691
	movt	r2, 29870
	ldr	r1, [sp, #68]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r3, #11103
	movt	r3, 11019
	str	r3, [sp]
	movw	r3, #24841
	movt	r3, 48821
	movw	r2, #21836
	movt	r2, 16059
	ldr	r1, [sp, #72]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r3, #1823
	movt	r3, 31279
	str	r3, [sp]
	movw	r3, #3379
	movt	r3, 41318
	movw	r2, #19192
	movt	r2, 30358
	ldr	r1, [sp, #76]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r2, #:lower16:.LC30
	movt	r2, #:upper16:.LC30
	str	r2, [sp, #100]
	mov	r0, r2
	bl	puts
	bl	clock
	str	r0, [sp, #108]
	ldm	r7, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	ldm	r6, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r7, sp, #464
	ldm	r7, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	add	r7, sp, #416
	ldr	r3, [sp, #48]
	stm	r3, {r0, r1, r2}
	mov	r6, #95
	str	r6, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	mov	r0, r7
	bl	modular_exponentiation_mont_32x3
	bl	clock
	ldr	r1, [sp, #108]
	sub	r6, r0, r1
	ldr	r1, [sp, #104]
	add	r1, r1, r6
	str	r1, [sp, #108]
	ldr	r3, [sp, #424]
	str	r3, [sp]
	ldr	r3, [sp, #420]
	ldr	r2, [sp, #416]
	ldr	r1, [sp, #80]
	ldr	r0, [sp, #44]
	bl	printf
	vmov	s15, r6	@ int
	vcvt.f64.s32	d16, s15
	str	r6, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	movw	r1, #:lower16:.LC31
	movt	r1, #:upper16:.LC31
	str	r1, [sp, #104]
	mov	r0, r1
	bl	puts
	bl	clock
	mov	r6, r0
	ldm	r7, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	add	r7, sp, #440
	ldm	r7, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r7, sp, #464
	ldm	r7, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldr	r3, [sp, #48]
	stm	r3, {r0, r1, r2}
	mov	r5, #95
	str	r5, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #404
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r6
	ldr	r7, [sp, #108]
	add	r7, r7, r0
	str	r7, [sp, #108]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d16, s15
	str	r0, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	ldr	r3, [sp, #412]
	str	r3, [sp]
	ldr	r3, [sp, #408]
	ldr	r2, [sp, #404]
	ldr	r1, [sp, #84]
	ldr	r0, [sp, #44]
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r7, sp, #392
	add	r6, r4, #48
	ldm	r6, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r5, r4, #108
	ldm	r5, {r0, r1, r2}
	add	r3, sp, #380
	stm	r3, {r0, r1, r2}
	add	r6, sp, #368
	add	r3, r4, #120
	ldm	r3, {r0, r1, r2}
	stm	r6, {r0, r1, r2}
	add	r3, r4, #132
	ldm	r3, {r0, r1, r2}
	b	.L60
.L61:
	.align	3
.L59:
	.word	0
	.word	1093567616
.L60:
	add	r3, sp, #356
	stm	r3, {r0, r1, r2}
	add	r5, sp, #344
	add	r0, r4, #144
	ldm	r0, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	movw	r0, #:lower16:.LC32
	movt	r0, #:upper16:.LC32
	bl	puts
	ldr	r0, [sp, #60]
	bl	puts
	ldr	r0, [sp, #96]
	str	r0, [sp]
	ldr	r3, [sp, #88]
	ldr	r2, [sp, #92]
	ldr	r1, [sp, #64]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r3, #623
	movt	r3, 30588
	movw	r2, #15898
	movt	r2, 17858
	movw	r1, #41985
	movt	r1, 42782
	str	r1, [sp, #124]
	str	r1, [sp]
	str	r3, [sp, #116]
	str	r2, [sp, #120]
	ldr	r1, [sp, #68]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r3, #45589
	movt	r3, 61504
	str	r3, [sp]
	movw	r3, #27703
	movt	r3, 41230
	movw	r2, #24961
	movt	r2, 10056
	ldr	r1, [sp, #72]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r3, #17233
	movt	r3, 43944
	str	r3, [sp]
	movw	r3, #18682
	movt	r3, 21659
	movw	r2, #8029
	movt	r2, 51045
	ldr	r1, [sp, #76]
	ldr	r0, [sp, #44]
	bl	printf
	ldr	r0, [sp, #100]
	bl	puts
	bl	clock
	str	r0, [sp, #112]
	ldm	r7, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	ldm	r6, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r7, sp, #380
	ldm	r7, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	add	r7, sp, #332
	ldr	ip, [sp, #48]
	stm	ip, {r0, r1, r2}
	mov	r6, #95
	str	r6, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	mov	r0, r7
	bl	modular_exponentiation_mont_32x3
	bl	clock
	ldr	r6, [sp, #112]
	sub	r6, r0, r6
	ldr	lr, [sp, #108]
	add	lr, lr, r6
	str	lr, [sp, #108]
	ldr	r3, [sp, #340]
	str	r3, [sp]
	ldr	r3, [sp, #336]
	ldr	r2, [sp, #332]
	ldr	r1, [sp, #80]
	ldr	r0, [sp, #44]
	bl	printf
	vmov	s15, r6	@ int
	vcvt.f64.s32	d16, s15
	str	r6, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	ldr	r0, [sp, #104]
	bl	puts
	bl	clock
	mov	r6, r0
	ldm	r7, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	add	r7, sp, #356
	ldm	r7, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	add	r7, sp, #380
	ldm	r7, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldr	ip, [sp, #48]
	stm	ip, {r0, r1, r2}
	mov	r5, #95
	str	r5, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #320
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r6
	ldr	r7, [sp, #108]
	add	r7, r7, r0
	str	r7, [sp, #108]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d16, s15
	str	r0, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	ldr	r3, [sp, #328]
	str	r3, [sp]
	ldr	r3, [sp, #324]
	ldr	r2, [sp, #320]
	ldr	r1, [sp, #84]
	ldr	r0, [sp, #44]
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r7, sp, #308
	add	r6, r4, #48
	ldm	r6, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r6, sp, #296
	add	r5, r4, #108
	ldm	r5, {r0, r1, r2}
	stm	r6, {r0, r1, r2}
	add	r3, r4, #156
	ldm	r3, {r0, r1, r2}
	add	r5, sp, #284
	stm	r5, {r0, r1, r2}
	add	r5, sp, #272
	sub	r3, r3, #12
	ldm	r3, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	movw	r0, #:lower16:.LC33
	movt	r0, #:upper16:.LC33
	bl	puts
	ldr	r0, [sp, #60]
	bl	puts
	ldr	r2, [sp, #96]
	str	r2, [sp]
	ldr	r3, [sp, #88]
	ldr	r2, [sp, #92]
	ldr	r1, [sp, #64]
	ldr	r0, [sp, #44]
	bl	printf
	ldr	r1, [sp, #124]
	str	r1, [sp]
	ldr	r3, [sp, #116]
	ldr	r2, [sp, #120]
	ldr	r1, [sp, #68]
	ldr	r0, [sp, #44]
	bl	printf
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp]
	mov	r3, #0
	mov	r2, r3
	ldr	r1, [sp, #72]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r3, #47657
	movt	r3, 63748
	str	r3, [sp]
	movw	r3, #33530
	movt	r3, 35614
	movw	r2, #2692
	movt	r2, 28575
	ldr	r1, [sp, #76]
	ldr	r0, [sp, #44]
	bl	printf
	ldr	r0, [sp, #100]
	bl	puts
	bl	clock
	str	r0, [sp, #100]
	ldm	r7, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	mov	r7, #0
	str	r7, [sp, #140]
	str	r7, [sp, #144]
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp, #148]
	ldm	r6, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldr	ip, [sp, #48]
	stm	ip, {r0, r1, r2}
	mov	r7, #95
	str	r7, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	ip, sp, #260
	mov	r0, ip
	bl	modular_exponentiation_mont_32x3
	bl	clock
	ldr	r3, [sp, #100]
	sub	r7, r0, r3
	ldr	r3, [sp, #108]
	add	r3, r3, r7
	str	r3, [sp, #100]
	ldr	r3, [sp, #268]
	str	r3, [sp]
	ldr	r3, [sp, #264]
	ldr	r2, [sp, #260]
	ldr	r1, [sp, #80]
	ldr	r0, [sp, #44]
	bl	printf
	vmov	s15, r7	@ int
	vcvt.f64.s32	d16, s15
	str	r7, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	ldr	r0, [sp, #104]
	bl	puts
	bl	clock
	mov	r7, r0
	add	r3, sp, #260
	ldm	r3, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	add	r3, sp, #284
	ldm	r3, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	ldm	r6, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldr	ip, [sp, #48]
	stm	ip, {r0, r1, r2}
	mov	r5, #95
	str	r5, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	r0, sp, #248
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r7
	ldr	r5, [sp, #100]
	add	r5, r5, r0
	str	r5, [sp, #100]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d16, s15
	str	r0, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	ldr	r3, [sp, #256]
	str	r3, [sp]
	ldr	r3, [sp, #252]
	ldr	r2, [sp, #248]
	ldr	r1, [sp, #84]
	ldr	r0, [sp, #44]
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r6, r4, #48
	ldm	r6, {r0, r1, r2}
	add	r6, sp, #236
	stm	r6, {r0, r1, r2}
	add	r6, sp, #224
	add	r3, r4, #168
	ldm	r3, {r0, r1, r2}
	stm	r6, {r0, r1, r2}
	add	r7, sp, #212
	add	r3, r4, #180
	ldm	r3, {r0, r1, r2}
	stm	r7, {r0, r1, r2}
	add	r5, sp, #200
	add	r4, r4, #192
	ldm	r4, {r0, r1, r2}
	stm	r5, {r0, r1, r2}
	movw	r0, #:lower16:.LC34
	movt	r0, #:upper16:.LC34
	bl	puts
	ldr	r0, [sp, #60]
	bl	puts
	ldr	r0, [sp, #96]
	str	r0, [sp]
	ldr	r3, [sp, #88]
	ldr	r2, [sp, #92]
	ldr	r1, [sp, #64]
	ldr	r4, [sp, #44]
	mov	r0, r4
	bl	printf
	movw	r3, #10679
	movt	r3, 24596
	str	r3, [sp]
	movw	r3, #3780
	movt	r3, 64265
	movw	r2, #21166
	movt	r2, 41173
	ldr	r1, [sp, #68]
	mov	r0, r4
	bl	printf
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp]
	mov	r3, #0
	mov	r2, r3
	ldr	r1, [sp, #72]
	mov	r0, r4
	bl	printf
	movw	r3, #35113
	movt	r3, 39
	str	r3, [sp]
	movw	r3, #5301
	movt	r3, 25941
	movw	r2, #19747
	movt	r2, 21666
	ldr	r1, [sp, #76]
	str	r4, [sp, #44]
	mov	r0, r4
	bl	printf
	movw	r0, #:lower16:.LC35
	movt	r0, #:upper16:.LC35
	bl	puts
	bl	clock
	mov	r4, r0
	add	r2, sp, #236
	ldm	r2, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	mov	r2, #0
	str	r2, [sp, #140]
	str	r2, [sp, #144]
	mov	r3, #1
	bfi	r3, r3, #16, #16
	str	r3, [sp, #148]
	ldm	r6, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	ldr	ip, [sp, #48]
	stm	ip, {r0, r1, r2}
	mov	r3, #96
	str	r3, [sp, #24]
	ldm	r10, {r0, r1, r2}
	ldr	lr, [sp, #52]
	stm	lr, {r0, r1, r2}
	ldm	r8, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	ldm	fp, {r1, r2, r3}
	add	ip, sp, #188
	mov	r0, ip
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r4
	ldr	r3, [sp, #100]
	add	r3, r3, r0
	str	r3, [sp, #48]
	vmov	s15, r0	@ int
	vcvt.f64.s32	d16, s15
	str	r0, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	ldr	r0, [sp, #56]
	bl	printf
	ldr	r3, [sp, #196]
	str	r3, [sp]
	ldr	r3, [sp, #192]
	ldr	r2, [sp, #188]
	ldr	r1, [sp, #80]
	ldr	r0, [sp, #44]
	bl	printf
	movw	r0, #:lower16:.LC36
	movt	r0, #:upper16:.LC36
	bl	puts
	bl	clock
	mov	r4, r0
	add	r2, sp, #188
	ldm	r2, {r0, r1, r2}
	stm	fp, {r0, r1, r2}
	ldm	r7, {r0, r1, r2}
	stm	r8, {r0, r1, r2}
	ldm	r6, {r0, r1, r2}
	stm	r10, {r0, r1, r2}
	ldm	r5, {r0, r1, r2}
	stm	r9, {r0, r1, r2}
	add	r3, sp, #28
	add	r2, sp, #164
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	mov	r3, #96
	str	r3, [sp, #24]
	add	r3, sp, #12
	add	r2, sp, #152
	ldm	r2, {r0, r1, r2}
	stm	r3, {r0, r1, r2}
	add	r3, sp, #140
	ldm	r3, {r0, r1, r2}
	stm	sp, {r0, r1, r2}
	add	r3, sp, #128
	ldm	r3, {r1, r2, r3}
	add	r0, sp, #176
	bl	modular_exponentiation_mont_32x3
	bl	clock
	sub	r0, r0, r4
	ldr	r3, [sp, #48]
	add	fp, r3, r0
	vmov	s15, r0	@ int
	vcvt.f64.s32	d16, s15
	str	r0, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	movw	r0, #:lower16:.LC25
	movt	r0, #:upper16:.LC25
	bl	printf
	ldr	r3, [sp, #184]
	str	r3, [sp]
	ldr	r3, [sp, #180]
	ldr	r2, [sp, #176]
	movw	r1, #:lower16:.LC28
	movt	r1, #:upper16:.LC28
	movw	r0, #:lower16:.LC17
	movt	r0, #:upper16:.LC17
	bl	printf
	movw	r0, #:lower16:.LC19
	movt	r0, #:upper16:.LC19
	bl	puts
	vmov	s15, fp	@ int
	vcvt.f64.s32	d16, s15
	str	fp, [sp]
	vdiv.f64	d16, d16, d8
	vmov	r2, r3, d16
	movw	r0, #:lower16:.LC37
	movt	r0, #:upper16:.LC37
	bl	printf
	mov	r0, #0
	add	sp, sp, #564
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
.LC0:
	.word	0
	.word	20480
	.word	1929379841
.LC1:
	.word	0
	.word	41826
	.word	-58768923
.LC2:
	.word	0
	.word	7608
	.word	911710445
.LC3:
	.word	0
	.word	9819
	.word	-1557927984
.LC4:
	.word	937702794
	.word	45230319
	.word	-1074083701
.LC5:
	.word	1957587011
	.word	2032283125
	.word	-895466405
.LC6:
	.word	1052464460
	.word	-1095409399
	.word	722152287
.LC7:
	.word	1989561080
	.word	-1587147469
	.word	2049902367
.LC8:
	.word	1714386002
	.word	-223213644
	.word	-552269267
.LC9:
	.word	1170357786
	.word	2004615791
	.word	-1491164159
.LC10:
	.word	659054977
	.word	-1592890313
	.word	-264195563
.LC11:
	.word	-949674147
	.word	1419462906
	.word	-1415036079
.LC12:
	.word	40048680
	.word	-764841694
	.word	62299219
.LC13:
	.word	1872693892
	.word	-1960934662
	.word	-117130711
.LC14:
	.word	-1596632402
	.word	-83292476
	.word	1611934135
.LC15:
	.word	1419922723
	.word	1700074677
	.word	2591017
.LC16:
	.word	1502693328
	.word	169084145
	.word	-1241131476
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC17:
	.ascii	"%s = %08x%08x%08x\015\012\000"
.LC18:
	.ascii	"Perfoming Test 1 - 48 bit keys\000"
	.space	1
.LC19:
	.ascii	"----------------------\000"
	.space	1
.LC20:
	.ascii	"Plain Text\000"
	.space	1
.LC21:
	.ascii	"PQ\000"
	.space	1
.LC22:
	.ascii	"E\000"
	.space	2
.LC23:
	.ascii	"D\000"
	.space	2
.LC24:
	.ascii	"Encrypting 48 bit...\000"
	.space	3
.LC25:
	.ascii	"Time taken = %fs, Clock Cycles = %ld\012\000"
	.space	2
.LC26:
	.ascii	"Encrypted Cipher Text\000"
	.space	2
.LC27:
	.ascii	"Decrypting 48 bit...\000"
	.space	3
.LC28:
	.ascii	"Decrypted Plain Text\000"
	.space	3
.LC29:
	.ascii	"Perfoming Test 2 - 95 bit keys\000"
	.space	1
.LC30:
	.ascii	"Encrypting 95 bit...\000"
	.space	3
.LC31:
	.ascii	"Decrypting 95 bit...\000"
	.space	3
.LC32:
	.ascii	"Perfoming Test 3 - 95 bit keys\000"
	.space	1
.LC33:
	.ascii	"Perfoming Test 4 - 95 bit keys\000"
	.space	1
.LC34:
	.ascii	"Perfoming Test 5 - 96 bit keys\000"
	.space	1
.LC35:
	.ascii	"Encrypting 96 bit...\000"
	.space	3
.LC36:
	.ascii	"Decrypting 96 bit...\000"
	.space	3
.LC37:
	.ascii	"Total Time taken = %fs, Clock Cycles = %ld\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
