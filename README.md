# SENG440 - RSA Cryptography Optimization for Embedded Systems
Processor model: ARMv7 Processor

### Build Instructions
To build the executable, run **make**\
To build .s assembly files, run **make asm**\
To build all files (assembly and executable), run **make all**

### .c files
montgomery_96bit.c
- Original functional 96-bit RSA Encryption Decryption algorithm
	
montgomery_96bit_optimized_v1.c
- Performed Optimization to MMM
    - Storing only relevant 32-bit chunks of uint32x3_t
    - Avoid loop counter i as argument in rshift_uint32x3
	
montgomery_96bit_optimized_v2.c
- Modified uint32x3_t to have 3 variables instead of an array of size 3
- Loop Unrolling to add_uint32x3
- Loop Unrolling to sub_uint32x3

montgomery_96bit_optimized_v2neon.c
- Attempted to use neon operations for add_uint32x3, but the overhead of loading the 96 bits from arm to NEON and back is too costly and reduced overall performance
- **Neon is not pursued further**

montgomery_96bit_optimized_v3.c
- Changed rshift1_uint32x3 from shifting by argument i to 2 routines handling specifically shift by 1 and shift by 32

montgomery_96bit_optimized_v4.c
- Register keywords to aid the compiler
- **This is the final iteration of the fully optimized version that provides the best performance results**

mmm_95bit_before_loop_unroll_test.c & mmm_95bit_after_loop_unroll_test.c
- Variant of montgomery_96bit_optimized_v4.c that only tests specifically 95-bit keys in a loop
- Since the project target is 95-bit keys, loop unrolling was done by unrolling the body of the loop 5 times, as 5 is the lowest divisor of 95
- This results in the algorithm being no longer compatible with bit sizes which can not be divided by 5
- The <em>before</em> and <em>after</em> specifies before and after performing loop unrolling in MMM algorithm
- **Loop unrolling reduced overall performance by increasing cycle count**
