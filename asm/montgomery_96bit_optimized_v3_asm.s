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
	.file	"montgomery_96bit_optimized_v3.c"
	.text
	.align	2
	.global	add_uint32x3
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	add_uint32x3, %function
add_uint32x3:
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
	.size	add_uint32x3, .-add_uint32x3
	.align	2
	.global	sub_uint32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	sub_uint32x3, %function
sub_uint32x3:
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
	.size	sub_uint32x3, .-sub_uint32x3
	.align	2
	.global	cmp_uint32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	cmp_uint32x3, %function
cmp_uint32x3:
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
	.size	cmp_uint32x3, .-cmp_uint32x3
	.align	2
	.global	rshift1_uint32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	rshift1_uint32x3, %function
rshift1_uint32x3:
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
	.size	rshift1_uint32x3, .-rshift1_uint32x3
	.align	2
	.global	rshift32_uint32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	rshift32_uint32x3, %function
rshift32_uint32x3:
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
	.size	rshift32_uint32x3, .-rshift32_uint32x3
	.align	2
	.global	print_uint32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	print_uint32x3, %function
print_uint32x3:
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
	.size	print_uint32x3, .-print_uint32x3
	.align	2
	.global	modular_multiplication_32x3
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	modular_multiplication_32x3, %function
modular_multiplication_32x3:
	@ args = 28, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #60
	str	r0, [sp, #40]
	add	r0, sp, #56
	stmdb	r0, {r1, r2, r3}
	ldr	r3, [sp, #44]
	str	r3, [sp, #16]
	ldr	r3, [sp, #48]
	str	r3, [sp, #12]
	ldr	r3, [sp, #52]
	str	r3, [sp, #8]
	ldr	r2, [sp, #104]
	str	r2, [sp, #20]
	ldr	r3, [sp, #120]
	cmp	r3, #0
	ble	.L20
	and	fp, r2, #1
	mov	r8, #0
	mov	r10, r8
	mov	r3, r8
	mov	r7, r8
	mov	r9, r8
	mov	r0, r2
	mov	r1, #0
	strd	r0, [sp, #24]
	b	.L28
.L43:
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #12]
	str	r2, [sp, #8]
	ldr	r2, [sp, #16]
	str	r2, [sp, #12]
	mov	r2, #0
	str	r2, [sp, #16]
	b	.L21
.L44:
	ldr	ip, [sp, #96]
	ldr	lr, [sp, #100]
	ldrd	r4, [sp, #24]
	adds	r4, r4, r10
	adc	r5, r5, #0
	ldr	r1, [sp, #20]
	add	r10, r10, r1
	mov	r1, #0
	adds	r0, lr, r8
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r8, r4
	adds	r0, ip, r3
	adds	r2, r0, r5
	mov	r3, r2
	cmp	r2, ip
	bhi	.L22
	beq	.L41
.L34:
	add	r9, r9, #1
	b	.L22
.L41:
	cmp	r4, lr
	bhi	.L22
	bne	.L34
	ldr	r1, [sp, #20]
	cmp	r10, r1
	movcs	r8, lr
	movcs	r3, ip
	bcs	.L22
	b	.L34
.L33:
	add	r9, r9, #1
.L25:
	lsl	r2, r8, #31
	add	r10, r2, r10, lsr #1
	lsl	r2, r3, #31
	add	r8, r2, r8, lsr #1
	lsr	r3, r3, #1
	add	r3, r3, r9, lsl #31
	lsr	r9, r9, #1
	lsr	r6, r6, #1
	add	r7, r7, #1
	ldr	r2, [sp, #120]
	cmp	r2, r7
	beq	.L42
.L28:
	tst	r7, #31
	beq	.L43
.L21:
	and	r2, r6, fp
	eor	r2, r2, r10
	and	r2, r2, #1
	str	r2, [sp, #4]
	tst	r6, #1
	bne	.L44
.L22:
	ldr	r2, [sp, #4]
	cmp	r2, #0
	beq	.L25
	ldr	r2, [sp, #108]
	mov	lr, r2
	ldr	r2, [sp, #112]
	str	r2, [sp, #4]
	ldr	ip, [sp, #116]
	mov	r1, #0
	adds	r4, ip, r10
	adc	r5, r1, #0
	add	r10, r10, ip
	mov	r1, #0
	adds	r0, r2, r8
	adc	r1, r1, #0
	adds	r4, r0, r5
	adc	r5, r1, r5, asr #31
	mov	r8, r4
	adds	r0, lr, r3
	adds	r2, r0, r5
	mov	r3, r2
	cmp	r2, lr
	bhi	.L25
	bne	.L33
	ldr	r2, [sp, #4]
	cmp	r4, r2
	bhi	.L25
	bne	.L33
	cmp	r10, ip
	ldrcs	r8, [sp, #4]
	movcs	r3, lr
	bcs	.L25
	b	.L33
.L42:
	tst	r9, #1
	bne	.L29
	ldr	r2, [sp, #108]
	cmp	r3, r2
	bhi	.L29
.L35:
	cmp	r2, r3
	bne	.L32
	ldr	r2, [sp, #112]
	cmp	r2, r8
	bcc	.L29
	bne	.L32
	ldr	r2, [sp, #116]
	cmp	r2, r10
	bhi	.L32
.L29:
	ldr	r2, [sp, #116]
	mov	r4, #0
	mov	r5, #1
	subs	r4, r4, r2
	sbc	r5, r5, #0
	adds	r0, r4, r10
	adc	r1, r5, #0
	mov	r10, r0
	mvn	r6, #0
	mov	r7, #0
	cmp	r1, r7
	cmpeq	r0, r6
	movls	r2, #1
	movhi	r2, #0
	mov	ip, #0
	ldr	lr, [sp, #112]
	mov	r0, #0
	mov	r1, #1
	subs	r0, r0, lr
	sbc	r1, r1, #0
	adds	r4, r0, r8
	adc	r5, r1, #0
	subs	r2, r4, r2
	str	r2, [sp, #32]
	sbc	r2, r5, ip
	str	r2, [sp, #36]
	ldrd	r0, [sp, #32]
	mov	r8, r0
	cmp	r1, r7
	cmpeq	r0, r6
	movls	r1, #1
	movhi	r1, ip
	ldr	r2, [sp, #108]
	sub	r3, r3, r2
	sub	r3, r3, r1
.L32:
	ldr	r2, [sp, #40]
	str	r3, [r2]
	str	r8, [r2, #4]
	str	r10, [r2, #8]
	mov	r0, r2
	add	sp, sp, #60
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L20:
	ldr	r2, [sp, #108]
	mov	r10, #0
	mov	r3, r10
	mov	r8, r10
	b	.L35
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
	b	.L46
.L48:
	tst	r8, #1
	beq	.L47
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
.L47:
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
.L46:
	cmp	r8, #0
	bne	.L48
	orrs	r3, r9, r10
	bne	.L47
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
	vcvt.f64.s32	d7, s15
	vldr.64	d8, .L56
	movw	r1, #:lower16:.LC25
	movt	r1, #:upper16:.LC25
	ldr	r0, [sp, #84]
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r6, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	b	.L57
.L58:
	.align	3
.L56:
	.word	0
	.word	1093567616
.L57:
	ldm	r3, {r0, r1, r2}
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
	vcvt.f64.s32	d7, s15
	str	r6, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r7, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	r0, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
	vcvt.f64.s32	d7, s15
	str	fp, [sp]
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
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
