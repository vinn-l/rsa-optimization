#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <inttypes.h>
#include <time.h>

// uint96_t consists of array of 3 uint32_t
typedef struct uint96_t {
    uint32_t value[3];
} uint96_t;

// uint96_t operations, only these are required and thus implemented
uint96_t add_uint96(uint96_t, uint96_t);
uint96_t sub_uint96(uint96_t, uint96_t);
uint96_t rshift_uint96(uint96_t, int);
uint32_t cmp_uint96(uint96_t, uint96_t);
void print_uint96(char*, uint96_t);

uint96_t modular_multiplication_32x3(uint96_t, uint96_t, uint96_t, uint32_t);
uint96_t modular_exponentiation_32x3(uint96_t, uint96_t, uint96_t, uint32_t, uint96_t);

uint96_t add_uint96(uint96_t x, uint96_t y)
{
    uint96_t result = {0};
    unsigned int carry = 0;
    int i = sizeof(x.value)/sizeof(x.value[0]);
    /* Start from LSB */
    while(i--)
    {
        uint64_t tmp = (uint64_t)x.value[i] + y.value[i] + carry;    
        result.value[i] = (uint32_t)tmp;
        /* Remember the carry */
        carry = tmp >> 32;
    }
    return result;
}

// Assumes that x >= y
uint96_t sub_uint96(uint96_t x, uint96_t y)
{
    uint96_t result = {0};

	uint64_t res;
	uint64_t tmp1;
	uint64_t tmp2;
	int borrow = 0;
	int i = sizeof(x.value)/sizeof(x.value[0]);
	while(i--)
	{
		tmp1 = (uint64_t)x.value[i] + ((uint64_t)0xFFFFFFFF + 1); /* + number_base */
		tmp2 = (uint64_t)y.value[i] + borrow;
		res = (tmp1 - tmp2);
		result.value[i] = (uint32_t)(res & (uint64_t)0xFFFFFFFF); /* "modulo number_base" == "% (number_base - 1)" if number_base is 2^N */
		borrow = (res <= (uint64_t)0xFFFFFFFF);
	}
    return result;
}

// Returns 0 if x >= y, 1 if x < y
uint32_t cmp_uint96(uint96_t x, uint96_t y)
{
    // check high
    if (x.value[0] > y.value[0]){
        return 0;
    }

    if (x.value[0] == y.value[0]){
        // check mid
        if (x.value[1] > y.value[1]){
            return 0;
        }

        if (x.value[1] == y.value[1]){
            // check low
            if (x.value[2] >= y.value[2]){
                return 0;
            }
        }
    }
    return 1;
}

uint96_t rshift_uint96(uint96_t x, int i)
{
    uint96_t result = {0};

    //if shift is more than or equal to 64
    if (i >= 64){
        result.value[2] = x.value[0];
        result.value[1] = 0;
        result.value[0] = 0;
        i -= 64;
        result.value[2] >>= i;
        return result;
    }

    //if shift is more than or equal to 32
    if (i >= 32){
        result.value[2] = x.value[1];
        result.value[1] = x.value[0];
        result.value[0] = 0;
        i -= 32;
        result.value[2] >>= i;
        result.value[2] += result.value[1] << (32 - i);
        result.value[1] >>= i;
        return result;
    }

    result.value[2] = x.value[2] >> i;
    result.value[2] += x.value[1] << (32 - i);
    result.value[1] = x.value[1] >> i;
    result.value[1] += x.value[0] << (32 - i);
    result.value[0] = x.value[0] >> i;
    return result;
}

// Function to easily print a uint96_t in Hex.
void print_uint96(char *str, uint96_t x)
{
    printf("%s = %08x%08x%08x\r\n", str, x.value[0], x.value[1], x.value[2]);
}

uint96_t modular_exponentiation_mont_32x3(uint96_t b, uint96_t e, uint96_t m, uint32_t numBits, uint96_t r2_mod)
{
    uint96_t ONE = {0,0,1};
    uint96_t result = modular_multiplication_32x3(ONE, r2_mod, m, numBits);
    uint96_t p = modular_multiplication_32x3(b, r2_mod, m, numBits);

    // Check least first is more efficient
    // While e > 0
    while (e.value[2] || e.value[1] || e.value[0])
    { 
        if (e.value[2] & 1){
            result = modular_multiplication_32x3(result, p, m, numBits);
        }
        e = rshift_uint96(e, 1);
        p = modular_multiplication_32x3(p, p, m, numBits);
    }
    result = modular_multiplication_32x3(result, ONE, m, numBits);

    return result;
}

// Code written based of MMM pseudocode from slides
uint96_t modular_multiplication_32x3(uint96_t X, uint96_t Y, uint96_t M, uint32_t numBits)
{
    // Based on tests, 95 bit keys seems to not result in T_high overflowing past 1
    // However T_high is still required and might as well make it 32 bits if it is already going to take up a register.
    uint96_t T_low = {0};
    uint32_t T_high = 0;

    int m = numBits;

    for (int i = 0; i < m; i++)
    {
        // T(0) XOR (X(i) AND Y(0))
        uint32_t n = (T_low.value[2] & 1) ^ ((rshift_uint96(X, i).value[2] & 1) & (Y.value[2] & 1));

        // Do if operations here to avoid multiplication operation
        if (rshift_uint96(X, i).value[2] & 1){
            T_low = add_uint96(T_low, Y);

            // T smaller than Y means overflow occured
            if (cmp_uint96(T_low, Y)){
                T_high += 1;
            }
        }
        if (n){
            T_low = add_uint96(T_low, M);

            // // T smaller than M means overflow occured
            if (cmp_uint96(T_low, M)){
                T_high += 1;
            }
        }
        // Right shift T_low and T_high
        T_low = rshift_uint96(T_low, 1);
        T_low.value[0] += T_high << 31;
        T_high >>= 1;
    
    }

    // If T>= M, then T = T - M
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

    // Test Case 2 - 96 Bit
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