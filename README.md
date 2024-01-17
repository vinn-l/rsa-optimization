# SENG440 - RSA Cryptography Optimization for Embedded Systems
This project is part of a requirement for the SENG440 - Embedded Systems course offered in the University of Victoria in Summer 2021.

This project involves implementing and further optimizing the RSA Encryption and Decryption algorithm for an embedded system with a goal for using RSA private and public keys of size 95-bits.

A detailed report write-up can be found at **ProjectReport.pdf** in this repository.

### Table showing the Cycle Count Averages for each optimization step performed
| Version | Optimizations Performed                                      | Cycle Count Averages (-O0) | Cycle Count Averages (-O1) | Cycle Count Averages (-O3) |
|---------|--------------------------------------------------------------|--------------------------|--------------------------|--------------------------|
| v0      | Initial Operator Strength Reduction on multiplication       | 43017.8                  | 27207.2                  | 6116.6                   |
| v1      | + MMM Optimization                                          | 31139.2                  | 12256.2                  | 4931.2                   |
| v2      | + Loop Unrolling for uint96_t add and sub operations<br> + Avoid internal array indexing in uint96_t       | 29255.0                  | 4022.2                   | 5023.0                   |
| v2neon  | + Neon Addition (Not pursued / Removed for next version)    | 33277.4                  | 13961.6                  | 8141.6                   |
| v3      | + Rewriting rshift_uint96 to two functions handling only right shifts by 1 or 32 | 27711.8          | 3925.6                   | 5251.8                   |
| v4      | + Register Keyword                                          | 21813.4                  | 4254.2                   | 4830.0                   |


The version/iteration that provides the best performance is **montgomery_96bit_optimized_v4.c**

The .s files in the asm directory are generated by the compiler with -O1 flag, and were not further modified.


### Build Instructions
To build the executables, run **make**\
To build .s assembly files, run **make asm**\
To build all files (assembly and executable), run **make all**

### .c src files
montgomery_96bit.c
- Original functional 96-bit RSA Encryption Decryption algorithm
- Operator Strength Reduction performed to avoid 96bit multiplications in MMM
	
montgomery_96bit_optimized_v1.c
- Performed Optimization to MMM
    - Storing only relevant 32-bit chunks of uint96_t
    - Allowed change to rshift_uint96 from performing shifts of variable i ranging from 0-96, to only right shifts by 1 or 32.
	
montgomery_96bit_optimized_v2.c
- Modified uint96_t to have 3 variables instead of an array of size 3
- Loop Unrolling to add_uint96
- Loop Unrolling to sub_uint96

montgomery_96bit_optimized_v2neon.c
- Attempted to use neon operations for add_uint96, but the overhead of loading the 96 bits from arm to NEON and back is too costly and reduced overall performance
- **Neon is not pursued further**

montgomery_96bit_optimized_v3.c
- Rewrote rshift_uint96 function from shifting by argument i to two functions rshift1_uint96 and rshift32_uint96 handling specifically shift by 1 and shift by 32

montgomery_96bit_optimized_v4.c
- Register keywords to aid the compiler
- **This is the final iteration of the fully optimized version that provides the best performance results**

mmm_95bit_before_loop_unroll_test.c & mmm_95bit_after_loop_unroll_test.c
- Variant of montgomery_96bit_optimized_v4.c that only tests specifically 95-bit keys in a loop
- Since the project target is 95-bit keys, loop unrolling was done by unrolling the body of the loop 5 times, as 5 is the lowest divisor of 95
- This results in the algorithm being no longer compatible with bit sizes which can not be divided by 5
- The <em>before</em> and <em>after</em> specifies before and after performing loop unrolling in MMM algorithm
- **Loop unrolling reduced overall performance by increasing cycle count**
