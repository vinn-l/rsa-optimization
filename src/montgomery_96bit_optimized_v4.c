#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <inttypes.h>
#include <time.h>

// uint96_t consists of array of 3 uint32_t
typedef struct uint96_t {
    // Optimization: Array access requires accessing memory, change array to variables to allow storing to register.
    uint32_t high;
    uint32_t mid;
    uint32_t low;
} uint96_t;

// uint96_t operations, only these are required and thus implemented
uint96_t add_uint96(uint96_t, uint96_t);
uint96_t sub_uint96(uint96_t, uint96_t);
uint96_t rshift1_uint96(uint96_t);
uint96_t rshift32_uint96(uint96_t);
uint32_t cmp_uint96(uint96_t, uint96_t);
void print_uint96(char*, uint96_t);

uint96_t modular_multiplication_32x3(uint96_t, uint96_t, uint96_t, int);
uint96_t modular_exponentiation_mont_32x3(uint96_t, uint96_t, uint96_t, int, uint96_t);

uint96_t add_uint96(uint96_t x, uint96_t y)
{
    uint96_t result = {0};
    register int carry = 0;

    // Optimization: Loop Unrolling
    // Start from LSB 
    register uint64_t tmp = (uint64_t)x.low + y.low;  
    result.low = (uint32_t)tmp;
    // Remember the carry
    carry = tmp >> 32;

    tmp = (uint64_t)x.mid + y.mid + carry;    
    result.mid = (uint32_t)tmp;
    // Remember the carry
    carry = tmp >> 32;

    tmp = (uint64_t)x.high + y.high + carry;    
    result.high = (uint32_t)tmp;
    
    return result;
}

// Assumes that x >= y
uint96_t sub_uint96(uint96_t x, uint96_t y)
{
    uint96_t result = {0};

	register uint64_t res;
	register uint64_t tmp1;
	register uint64_t tmp2;
	register int borrow = 0;

    // Optimization: Loop Unrolling
    tmp1 = (uint64_t)x.low + ((uint64_t)0xFFFFFFFF + 1);
    tmp2 = (uint64_t)y.low;
    res = (tmp1 - tmp2);
    result.low = (uint32_t)(res & (uint64_t)0xFFFFFFFF);
    borrow = (res <= (uint64_t)0xFFFFFFFF);

    tmp1 = (uint64_t)x.mid + ((uint64_t)0xFFFFFFFF + 1);
    tmp2 = (uint64_t)y.mid + borrow;
    res = (tmp1 - tmp2);
    result.mid = (uint32_t)(res & (uint64_t)0xFFFFFFFF);
    borrow = (res <= (uint64_t)0xFFFFFFFF);

    tmp1 = (uint64_t)x.high + ((uint64_t)0xFFFFFFFF + 1);
    tmp2 = (uint64_t)y.high + borrow;
    res = (tmp1 - tmp2);
    result.high = (uint32_t)(res & (uint64_t)0xFFFFFFFF);

    return result;
}

// Returns 0 if x >= y, 1 if x < y
uint32_t cmp_uint96(uint96_t x, uint96_t y)
{
    // check high
    if (x.high > y.high){
        return 0;
    }

    if (x.high == y.high){
        // check mid
        if (x.mid > y.mid){
            return 0;
        }

        if (x.mid == y.mid){
            // check low
            if (x.low >= y.low){
                return 0;
            }
        }
    }
    return 1;
}

// Optimization: Since we know that rshift_uint96 is only used with constant 1 and constant 32
// We can create 2 routines specifically for these constants to reduce overhead of passing arguments, 
// but the compiler may be smart enough to optimize this overhead anyway if the arguments passed are constants.
// More importantly, doing this avoids all the if operations of whether a shift is more than or equal to 32 or 64, and the handling for values not specifically 1 or 32.
uint96_t rshift1_uint96(uint96_t x)
{
    uint96_t result = {0};

    result.low = x.low >> 1;
    result.low += x.mid << 31;
    result.mid = x.mid >> 1;
    result.mid += x.high << 31;
    result.high = x.high >> 1;
    return result;
}

uint96_t rshift32_uint96(uint96_t x)
{
    uint96_t result = {0};

    // Optimization: Shifting 32 is much simpler now because we know that the shift is always 32 and just have to do the following operations.
    // Compared to the previous iteration of rshift_uint96, we save a few cycles and code memory.
    result.low = x.mid;
    result.mid = x.high;
    result.high = 0;
    return result;
}

// Function to easily print a uint96_t in Hex.
void print_uint96(char *str, uint96_t x)
{
    printf("%s = %08x%08x%08x\r\n", str, x.high, x.mid, x.low);
}

uint96_t modular_exponentiation_mont_32x3(uint96_t b, register uint96_t e, register uint96_t m, int numBits, uint96_t r2_mod)
{
    uint96_t ONE = {0,0,1};
    register uint96_t result = modular_multiplication_32x3(ONE, r2_mod, m, numBits);
    register uint96_t p = modular_multiplication_32x3(b, r2_mod, m, numBits);

    // Optimization: Check low first, then mid, then high is more efficient
    // While e > 0
    while (e.low || e.mid || e.high)
    { 
        if (e.low & 1){
            result = modular_multiplication_32x3(result, p, m, numBits);
        }
        e = rshift1_uint96(e);
        p = modular_multiplication_32x3(p, p, m, numBits);
    }
    result = modular_multiplication_32x3(result, ONE, m, numBits);

    return result;
}

// Code written based of MMM pseudocode from slides
uint96_t modular_multiplication_32x3(uint96_t X, uint96_t Y, uint96_t M, int numBits)
{
    // Based on tests, 95 bit keys seems to not result in T_high overflowing past 1 
    // However T_high is still required and might as well make it 32 bits if it is already going to take up a register.
    register uint96_t T_low = {0};
    register uint32_t T_high = 0;
    register uint32_t n;

    // The lowest bit of X_32local is i-th bit

    // Optimization: The algorithm only requires the i-th bit of X, 
    // therefore a 32-bit register can be used to store relevent 32-bit chunks (high, mid, or low) of 96-bit X.
    register uint32_t X_32local;

    // Optimization: The index required from Y is always the 0-th index, or Y(0), thus this can be saved into a register and be reused for all loop iterations.
    register uint32_t Y_0 = Y.low & 1;
    
    for (register int i = 0; i < numBits; i++)
    {
        // Get the relevant 32-bits that is required and keep them into X_32local. 
        // X_32local will then be used instead of X to get the i-th bit, 
        // and will potentially save us registers because X_32local only requires 1 register whereas X requires 3.
        if(!(i % 32)){
            // This occurs only once every 32 loop iterations
            X_32local = X.low;
            X = rshift32_uint96(X);
        }

        // n = T(0) XOR (X(i) AND Y(0))
        n = (T_low.low & 1) ^ ((X_32local & 1) & Y_0);

        // T + X(i)Y
        if (X_32local & 1){
            T_low = add_uint96(T_low, Y);

            // T < Y means overflow occured
            if (cmp_uint96(T_low, Y)){
                T_high += 1;
            }
        }

        // T + nM
        if (n){
            T_low = add_uint96(T_low, M);

            // // T < M means overflow occured
            if (cmp_uint96(T_low, M)){
                T_high += 1;
            }
        }
        
        // T >> 1
        T_low = rshift1_uint96(T_low);
        T_low.high += T_high << 31;
        T_high >>= 1;

        // Shift X_32local down by 1 for every iteration to ensure i-th bit is always the lowest bit
        X_32local >>= 1;
    }

    // If T >= M, then T = T - M
    if (T_high & 1 || !cmp_uint96(T_low, M)){
        T_low = sub_uint96(T_low, M);
    }
    
    return T_low;
}

uint96_t encrypt(uint96_t plain_t, uint96_t E, uint96_t N, int numBits, uint96_t r2_mod){
    return modular_exponentiation_mont_32x3(plain_t, E, N, numBits, r2_mod);
}

uint96_t decrypt(uint96_t cipher_t, uint96_t D, uint96_t N, int numBits, uint96_t r2_mod){
    return modular_exponentiation_mont_32x3(cipher_t, D, N, numBits, r2_mod);
}

int main()
{
    // 48 bit Keys
    // n='a362fc7f41e5' e='000000010001' d='1db8365798ed'
    clock_t t;
    clock_t total = 0;
    double time_taken;
    uint96_t plain_t = {0, 0x00005000, 0x73000001};
    uint96_t N = {0, 0x0000a362, 0xfc7f41e5};
    uint96_t E = {0, 0, 0x00010001};
    uint96_t D = {0, 0x00001db8, 0x365798ed};
    uint96_t r2_mod_48_2 = {0, 0x0000265b, 0xa323e7d0};

    printf("Perfoming Test 1 - 48 bit keys\n");
    printf("----------------------\n");
    print_uint96("Plain Text", plain_t);
    print_uint96("PQ", N);
    print_uint96("E", E);
    print_uint96("D", D);
    printf("Encrypting 48 bit...\n");
    t = clock();
    uint96_t cipher_t = encrypt(plain_t, E, N, 48, r2_mod_48_2);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);
    print_uint96("Encrypted Cipher Text", cipher_t);
    
    printf("Decrypting 48 bit...\n");
    t = clock();
    uint96_t plain_t_res = decrypt(cipher_t, D, N, 48, r2_mod_48_2);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);
    print_uint96("Decrypted Plain Text", plain_t_res);
    printf("\n");

    // 95 bit Keys - 1
    // n'74AE684379222DF5CAA0445B' e'3EBB554CBEB561092B0B2B5F' d'76964AF8A1660D337A2F071F'
    uint96_t plain_t_95 = {0x37E4358A, 0x02B228EF, 0xBFFAC88B};
    uint96_t N_95 = {0x74AE6843, 0x79222DF5, 0xCAA0445B};
    uint96_t E_95 = {0x3EBB554C, 0xBEB56109, 0x2B0B2B5F};
    uint96_t D_95 = {0x76964AF8, 0xA1660D33, 0x7A2F071F};
    uint96_t r2_mod_95_2_95 = {0x662F7452, 0xF2B207B4, 0xDF150A2D};

    printf("Perfoming Test 2 - 95 bit keys\n");
    printf("----------------------\n");
    print_uint96("Plain Text", plain_t_95);
    print_uint96("PQ", N_95);
    print_uint96("E", E_95);
    print_uint96("D", D_95);
    printf("Encrypting 95 bit...\n");
    // printf("Expected Cipher Text = 0x5E540B6F3B7B69CC81648395\n");
    
    t = clock();
    uint96_t cipher_t_95 = encrypt(plain_t_95, E_95, N_95, 95, r2_mod_95_2_95);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    print_uint96("Encrypted Cipher Text", cipher_t_95);
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);

    printf("Decrypting 95 bit...\n");
    t = clock();
    uint96_t plain_t_res_95 = decrypt(cipher_t_95, D_95, N_95, 95, r2_mod_95_2_95);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);
    print_uint96("Decrypted Plain Text", plain_t_res_95);
    printf("\n");

    // 95 bit Keys - 2
    // n'45C23E1A777C026FA71EA401' e'27486181A10E6C37F040B215' d'C7651F5D549B48FAABA84351'
    uint96_t plain_t_95_2 = {0x37E4358A, 0x02B228EF, 0xBFFAC88B};
    uint96_t N_95_2 = {0x45C23E1A, 0x777C026F, 0xA71EA401};
    uint96_t E_95_2 = {0x27486181, 0xA10E6C37, 0xF040B215};
    uint96_t D_95_2 = {0xC7651F5D, 0x549B48FA, 0xABA84351};
    uint96_t r2_mod_95_2_95_2 = {0x2631828, 0xD2697122, 0x03B69C53};

    printf("Perfoming Test 3 - 95 bit keys\n");
    printf("----------------------\n");
    print_uint96("Plain Text", plain_t_95_2);
    print_uint96("PQ", N_95_2);
    print_uint96("E", E_95_2);
    print_uint96("D", D_95_2);
    printf("Encrypting 95 bit...\n");
    // printf("Expected Cipher Text = 0x5E540B6F3B7B69CC81648395\n");
    
    t = clock();
    uint96_t cipher_t_95_2 = encrypt(plain_t_95_2, E_95_2, N_95_2, 95, r2_mod_95_2_95_2);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    print_uint96("Encrypted Cipher Text", cipher_t_95_2);
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);

    printf("Decrypting 95 bit...\n");
    t = clock();
    uint96_t plain_t_res_95_2 = decrypt(cipher_t_95_2, D_95_2, N_95_2, 95, r2_mod_95_2_95_2);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);
    print_uint96("Decrypted Plain Text", plain_t_res_95_2);
    printf("\n");

    // 95 bit Keys - 3
    // n'45C23E1A777C026FA71EA401' e'000000000000000000010001' d'6F9F0A848B1E82FAF904BA29'
    uint96_t plain_t_95_3 = {0x37E4358A, 0x02B228EF, 0xBFFAC88B};
    uint96_t N_95_3 = {0x45C23E1A, 0x777C026F, 0xA71EA401};
    uint96_t E_95_3 = {0x00000000, 0x00000000, 0x00010001};
    uint96_t D_95_3 = {0x6F9F0A84, 0x8B1E82FA, 0xF904BA29};
    uint96_t r2_mod_95_2_95_3 = {0x2631828, 0xD2697122, 0x03B69C53};

    printf("Perfoming Test 4 - 95 bit keys\n");
    printf("----------------------\n");
    print_uint96("Plain Text", plain_t_95_3);
    print_uint96("PQ", N_95_3);
    print_uint96("E", E_95_3);
    print_uint96("D", D_95_3);
    printf("Encrypting 95 bit...\n");
    // printf("Expected Cipher Text = 0x5E540B6F3B7B69CC81648395\n");
    
    t = clock();
    uint96_t cipher_t_95_3 = encrypt(plain_t_95_3, E_95_3, N_95_3, 95, r2_mod_95_2_95_3);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    print_uint96("Encrypted Cipher Text", cipher_t_95_3);
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);

    printf("Decrypting 95 bit...\n");
    t = clock();
    uint96_t plain_t_res_95_3 = decrypt(cipher_t_95_3, D_95_3, N_95_3, 95, r2_mod_95_2_95_3);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);
    print_uint96("Decrypted Plain Text", plain_t_res_95_3);
    printf("\n");

    // 96 bit Keys
    // n'a0d552aefb090ec4601429b7' e'000000000000000000010001' d'54a24d23655514b500278929'
    uint96_t plain_t_96_2 = {0x37E4358A, 0x02B228EF, 0xBFFAC88B};
    uint96_t N_96_2 = {0xa0d552ae, 0xfb090ec4, 0x601429b7};
    uint96_t E_96_2 = {0x00000000, 0x00000000, 0x00010001};
    uint96_t D_96_2 = {0x54a24d23,0x655514b5,0x00278929};
    uint96_t r2_mod_96_2 = {0x599147d0, 0x0a1404f1 ,0xb605d62c};

    printf("Perfoming Test 5 - 96 bit keys\n");
    printf("----------------------\n");
    print_uint96("Plain Text", plain_t_96_2);
    print_uint96("PQ", N_96_2);
    print_uint96("E", E_96_2);
    print_uint96("D", D_96_2);
    printf("Encrypting 96 bit...\n");
    t = clock();
    uint96_t cipher_t_96_2 = encrypt(plain_t_96_2, E_96_2, N_96_2, 96, r2_mod_96_2);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);
    print_uint96("Encrypted Cipher Text", cipher_t_96_2);

    printf("Decrypting 96 bit...\n");
    t = clock();
    uint96_t plain_t_res_96_2 = decrypt(cipher_t_96_2, D_96_2, N_96_2, 96, r2_mod_96_2);
    t = clock() - t;
    total += t;
    time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds
    printf("Time taken = %fs, Clock Cycles = %ld\n", time_taken, t);
    print_uint96("Decrypted Plain Text", plain_t_res_96_2);

    printf("----------------------\n");
    time_taken = ((double)total)/CLOCKS_PER_SEC; // in seconds
    printf("Total Time taken = %fs, Clock Cycles = %ld\n", time_taken, total);
    return 0;
}