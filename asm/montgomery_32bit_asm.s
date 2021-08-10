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
	.file	"montgomery_32bit.c"
	.text
	.align	2
	.global	count_bits
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	count_bits, %function
count_bits:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	subs	r3, r0, #0
	beq	.L4
	mov	r0, #0
.L3:
	add	r0, r0, #1
	asrs	r3, r3, #1
	bne	.L3
	bx	lr
.L4:
	mov	r0, r3
	bx	lr
	.size	count_bits, .-count_bits
	.align	2
	.global	modular_multiplication
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	modular_multiplication, %function
modular_multiplication:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r6, r0
	mov	r4, r1
	mov	r5, r2
	mov	r0, r2
	bl	count_bits
	subs	lr, r0, #0
	ble	.L11
	mov	r1, #0
	mov	r0, r1
.L9:
	asr	r3, r6, r1
	and	r3, r3, #1
	and	r2, r0, #1
	and	ip, r3, r4
	eor	r2, r2, ip
	mla	r3, r4, r3, r0
	mla	r3, r5, r2, r3
	asr	r0, r3, #1
	add	r1, r1, #1
	cmp	lr, r1
	bne	.L9
.L8:
	cmp	r5, r0
	suble	r0, r0, r5
	pop	{r4, r5, r6, pc}
.L11:
	mov	r0, #0
	b	.L8
	.size	modular_multiplication, .-modular_multiplication
	.global	__aeabi_idivmod
	.align	2
	.global	modular_exponentiation
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	modular_exponentiation, %function
modular_exponentiation:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r5, r0
	mov	r4, r1
	mov	r6, r2
	and	r3, r1, #1
	cmp	r3, #0
	movne	r7, r0
	moveq	r7, #1
	cmp	r1, #0
	bgt	.L18
.L14:
	mov	r0, r7
	pop	{r4, r5, r6, r7, r8, pc}
.L17:
	cmp	r4, #0
	ble	.L14
.L18:
	asr	r4, r4, #1
	mov	r1, r6
	mul	r0, r5, r5
	bl	__aeabi_idivmod
	mov	r5, r1
	tst	r4, #1
	beq	.L17
	mov	r1, r6
	mul	r0, r7, r5
	bl	__aeabi_idivmod
	mov	r7, r1
	b	.L17
	.size	modular_exponentiation, .-modular_exponentiation
	.align	2
	.global	modular_exponentiation_mont
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	modular_exponentiation_mont, %function
modular_exponentiation_mont:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r8, r0
	mov	r4, r1
	mov	r6, r2
	lsl	r3, r3, #1
	mov	r5, #1
	mov	r1, r2
	lsl	r0, r5, r3
	bl	__aeabi_idivmod
	mov	r9, r1
	mov	r2, r6
	mov	r0, r5
	bl	modular_multiplication
	mov	r7, r0
	mov	r2, r6
	mov	r1, r9
	mov	r0, r8
	bl	modular_multiplication
	mov	r5, r0
	cmp	r4, #0
	bgt	.L25
.L23:
	mov	r2, r6
	mov	r1, r7
	mov	r0, #1
	bl	modular_multiplication
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L24:
	asr	r4, r4, #1
	mov	r2, r6
	mov	r1, r5
	mov	r0, r5
	bl	modular_multiplication
	mov	r5, r0
	cmp	r4, #0
	ble	.L23
.L25:
	tst	r4, #1
	beq	.L24
	mov	r2, r6
	mov	r1, r5
	mov	r0, r7
	bl	modular_multiplication
	mov	r7, r0
	b	.L24
	.size	modular_exponentiation_mont, .-modular_exponentiation_mont
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r2, #23
	mov	r1, #22
	mov	r0, #17
	bl	modular_multiplication
	movw	r4, #:lower16:.LC0
	movt	r4, #:upper16:.LC0
	mov	r1, r0
	mov	r0, r4
	bl	printf
	movw	r2, #497
	mov	r1, #13
	mov	r0, #4
	bl	modular_exponentiation
	mov	r1, r0
	mov	r0, r4
	bl	printf
	movw	r0, #497
	bl	count_bits
	mov	r3, r0
	movw	r2, #497
	mov	r1, #13
	mov	r0, #4
	bl	modular_exponentiation_mont
	mov	r1, r0
	mov	r0, r4
	bl	printf
	mov	r0, #0
	pop	{r4, pc}
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%d\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
