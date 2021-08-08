#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <inttypes.h>

// uint32x3_t
typedef struct uint32x3_t {
    uint32_t value[3];
} uint32x3_t;

// typedef struct uint32x4_t {
//     uint32_t value[4];
// } uint32x4_t;

// uint32x3_t operations
uint32x3_t add_uint32x3(uint32x3_t, uint32x3_t);
uint32x3_t sub_uint32x3(uint32x3_t, uint32x3_t);
uint32x3_t rshift_uint32x3(uint32x3_t, int);
uint32_t cmp_uint32x3(uint32x3_t, uint32x3_t);
void print_uint32x3(char*, uint32x3_t);
// uint32x3_t mul(uint32x3_t, uint32x3_t);
// uint32x3_t div(uint32x3_t, uint32x3_t);
// uint32x3_t and(uint32x3_t, uint32x3_t);
// uint32x3_t or(uint32x3_t, uint32x3_t);
// uint32x3_t xor(uint32x3_t, uint32x3_t);
// uint32x3_t lshift(uint32x3_t, int); // not used
uint32x3_t modular_multiplication_32x3(uint32x3_t, uint32x3_t, uint32x3_t, uint32_t);
// uint32x3_t modular_exponentiation_32x3(uint32x3_t, uint32x3_t, uint32x3_t);

// // uint32x4_t operations
// uint32x3_t add_uint32x4(uint32x4_t, uint32x4_t);
// // uint32x3_t sub_uint32x4(uint32x3_t, uint32x3_t);
// uint32x3_t rshift_uint32x4(uint32x4_t, int);
// uint32_t cmp_uint32x4(uint32x4_t, uint32x3_t);
// void print_uint32x4(char*, uint32x4_t);

uint32x3_t add_uint32x3(uint32x3_t x, uint32x3_t y)
{
    uint32x3_t result = {0};
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

// uint32x3_t add_uint32x3_2(uint32x3_t x, uint32x3_t y)
// {
//     uint32x3_t result = {0};
//     unsigned int carry_low = 0;
//     unsigned int carry_mid = 0;

//     result.value[2] = x.value[2] + y.value[2];
//     result.value[1] = x.value[1] + y.value[1];
//     result.value[0] = x.value[0] + y.value[0];

//     // Order matters here

//     // check for overflow of lowest 32 bits, add carry to mid
//     if (result.value[2] < x.value[2]){
//         // printf("add mid\n");
//         ++result.value[1];
//     }

//     // check for overflow of mid 32 bits, add carry to high
//     if (result.value[1] < x.value[1]){
//         // printf("add high\n");
//         ++result.value[0];
//     }

//     return result;
// }

// Assume x >= y
uint32x3_t sub_uint32x3(uint32x3_t x, uint32x3_t y)
{
    uint32x3_t result = {0};

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

// // Assume x >= y
// uint32x3_t sub_uint32x3(uint32x3_t x, uint32x3_t y)
// {
//     uint32x3_t result = {0};

//     result.value[2] = x.value[2] - y.value[2];
//     result.value[1] = x.value[1] - y.value[1];
//     result.value[0] = x.value[0] - y.value[0];

//     // Order matters here

//     // check for underflow of lowest 32 bits, sub overflow to mid
//     if (result.value[2] > x.value[2]){
//         // printf("sub mid\n");
//         --result.value[1];
//     }

//     // check for underflow of mid 32 bits, sub underflow to high
//     if (result.value[1] > x.value[1]){
//         // printf("sub high\n");
//         --result.value[0];
//     }

//     return result;
// }

// return 0 if x >= y, 1 if x < y
uint32_t cmp_uint32x3(uint32x3_t x, uint32x3_t y)
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

uint32x3_t rshift_uint32x3(uint32x3_t x, int i)
{
    // shift right by 1
    uint32x3_t result = {0};

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

void print_uint32x3(char *str, uint32x3_t x)
{
    printf("%s = %08x%08x%08x\r\n", str, x.value[0], x.value[1], x.value[2]);
}

int count_bits(int i){
    int m = 0;
    while (i)
    {
        m++;
        i >>= 1;
    }

    return m;
}

int modular_exponentiation_mont(int b, int e, int m, int numBits)
{
    int r2m = (1 << (2 * numBits)) % m;
    printf("r2m: %d\n", r2m);
    int result = modular_multiplication(1, r2m, m, numBits);
    int p = modular_multiplication(b, r2m, m, numBits);

    // if (1 & e) // if e is odd
    //     result = b;
    while (e > 0)
    { // while e > 0
        if (e & 1)                     // if e is odd
            // result = (result * b) % m; // result = result * b % m
            result = modular_multiplication(result, p, m, numBits);

        e >>= 1;                       // e = e/2
        // b = (b * b) % m;               // b = b^2 % m
        p = modular_multiplication(p, p, m, numBits);
    }
    result = modular_multiplication(1, result, m, numBits);

    return result;
}

uint32x3_t modular_exponentiation_mont_32x3(uint32x3_t b, uint32x3_t e, uint32x3_t m, uint32_t numBits, uint32x3_t r2m)
{
    // this cant be done because 2^(2*numBits) is too big, if numBits is 95, then 2^(2*95) requires 191 bits 
    // therefore r2m must be precomputed with double the width of 96 bits
    // uint32x3_t r2m = (1 << (2 * numBits)) % m;
    uint32x3_t ONE = {0,0,1};
    uint32x3_t result = modular_multiplication_32x3(ONE, r2m, m, numBits);
    uint32x3_t p = modular_multiplication_32x3(b, r2m, m, numBits);

    // if (1 & e) // if e is odd
    //     result = b;

    // check least first is more efficient
    while (e.value[2] || e.value[1] || e.value[0])
    { // while e > 0
        if (e.value[2] & 1){                   // if e is odd
            // result = (result * b) % m; // result = result * b % m
            // p < m
            // result < m
            result = modular_multiplication_32x3(result, p, m, numBits);
        }
        // print_uint32x3("e", e);
        e = rshift_uint32x3(e, 1);                      // e = e/2
        // print_uint32x3("e", e);
        // b = (b * b) % m;               // b = b^2 % m
        p = modular_multiplication_32x3(p, p, m, numBits);
    }
    result = modular_multiplication_32x3(result, ONE, m, numBits);

    return result;
    // // uint32x3_t result = {0,0,1};
    // uint32x3_t result = modular_multiplication_32x3();

    // if (1 & e.value[2]) // if e is odd
    //     result = b;
    // while (e.value[0] > 0 || e.value[1] > 0 || e.value[2] > 0)
    // { // while e > 0
    //     rshift_uint32x3(e, 1);         // e = e/2
    //     b = modular_multiplication_32x3(b, b, m, numBits); // b = b^2 % m
    //     if (e.value[2] & 1)                     // if e is odd
    //         result = modular_multiplication_32x3(result, b, m, numBits); // result = result * b % m
    // }
    // return result;
}

// https://en.wikipedia.org/wiki/Modular_exponentiation
// Modular Exponentiation based on slides and also pseudocode on Wikipedia.
int modular_exponentiation(int b, int e, int m)
{
    int result = 1;

    // if (1 & e) // if e is odd
    //     result = b;
    while (e > 0)
    { // while e > 0
        // b = modular_multiplication(b, b, m);
        if (e & 1)                     // if e is odd
            result = (result * b) % m; // result = result * b % m
            // result = modular_multiplication(result, b, m);

        e >>= 1;                       // e = e/2
        b = (b * b) % m;               // b = b^2 % m
    }
    return result;
}

// Code written based of MMM pseudocode from slides

// Observation: RSA does not use negative X, Y and M, thus unsigned
// should be used to maximize number of representable positive integers
// changing to unsigned long long int should be done to allow 95 bit
// integers

uint32x3_t modular_multiplication_32x3(uint32x3_t X, uint32x3_t Y, uint32x3_t M, uint32_t numBits)
{
    uint32x3_t T_low = {0};
    uint32_t T_high = 0;

    int m = numBits;

    for (int i = 0; i < m; i++)
    {
        uint32_t n = (T_low.value[2] & 1) ^ ((rshift_uint32x3(X, i).value[2] & 1) & (Y.value[2] & 1));
        // printf("T(0) = %d\r\n", (T.value[0] & 1));
        // print_uint32x3("X", X);
        // printf("i: %d", i);
        // print_uint32x3("x_shift", rshift_uint32x3(X, i));
        // printf("X(i) = %d\r\n", (rshift_uint32x3(X, i).value[0] & 1));
        // printf("Y(0) = %d\r\n", (Y.value[0] & 1));
        // printf("n = %d\r\n", n);

        // Do if operations here to avoid multiplication operation
        if (rshift_uint32x3(X, i).value[2] & 1){
            // print_uint32x3("T", T);
            // print_uint32x3("Y", Y);

            T_low = add_uint32x3(T_low, Y);

            // print_uint32x3("T_add", T);

            // // T smaller than Y means overflow
            if (cmp_uint32x3(T_low, Y)){
                // printf("Overflow\n");
                T_high += 1;
            }

            // print_uint32x3("Result", T);
        }

        if (n){
            // print_uint32x3("T", T);
            // print_uint32x3("M", M);

            T_low = add_uint32x3(T_low, M);

            // print_uint32x3("T_add", T);

            // // T smaller than M means overflow
            if (cmp_uint32x3(T_low, M)){
                // printf("Overflow\n");
                T_high += 1;
            }

            // print_uint32x3("Result", T);
        }
        // if (!cmp_uint32x3(T_high, FOUR)){
        //     print_uint32x3("T_high", T_high);
        //     printf("T_high is >= 2\n");
        // }
        // T = rshift_uint32x3(T, 1);
        // right shift T_low and T_high
        T_low = rshift_uint32x3(T_low, 1);
        T_low.value[0] += T_high << 31;
        T_high >>= 1;
    
    }

    // print_uint32x3("T", T);
    // print_uint32x3("M", M);
    
    // T_high at max can be 1 at this point
    // if (T_high.value[2] & 1){
    //     print_uint32x3("T_high", T_high);
    //     printf("T_high is >= 1\n");
    // }

    if (T_high || !cmp_uint32x3(T_low, M)){
        // print_uint32x3("T", T);
        // print_uint32x3("M", M);
        T_low = sub_uint32x3(T_low, M);
        // print_uint32x3("T_sub", T);
    }

    // print_uint32x3("T", T);
    // print_uint32x3("M", M);
    // printf("%d\n", !cmp_uint32x3(T, M));
    
    return T_low;
}

// // Code written based of MMM pseudocode from slides

// // Observation: RSA does not use negative X, Y and M, thus unsigned
// // should be used to maximize number of representable positive integers
// // changing to unsigned long long int should be done to allow 95 bit
// // integers
// uint32x3_t modular_multiplication_32x3(uint32x3_t X, uint32x3_t Y, uint32x3_t M, uint32_t numBits)
// {
//     uint32x3_t T_low = {0};
//     uint32x3_t T_high = {0};
//     uint32x3_t ONE = {0,0,1};
//     int m = numBits;

//     // Observation: Loop unrolling can be performed, especially since
//     // only 2 operations in the loop, and the second operation is dependent
//     // on first.
//     for (int i = 0; i < m; i++)
//     {
//         // Observation: Repeated calculation of X(i), can store result
//         // in a register.

//         // Observation: Multiplication is expensive, but since
//         // multiplication is not going to be with a direct power of 2,
//         // difficult to identify how to optimize with bit operations.

//         // Observation: There are operations in T that is not dependent
//         // on n, such as (T + (((x >> i) & 1) * y)), ensure that
//         // compiler allows this to be run concurrently.
//         uint32_t n = (T_low.value[2] & 1) ^ ((rshift_uint32x3(X, i).value[2] & 1) & (Y.value[2] & 1));
//         // printf("T(0) = %d\r\n", (T.value[0] & 1));
//         // printf("X = %"PRIu32"\r\n", X.value[0]);
//         // printf("X_shift = %d by %i\r\n", (rshift_uint32x3(X, i), i));
//         // printf("X(i) = %d\r\n", (rshift_uint32x3(X, i).value[0] & 1));
//         // printf("Y(0) = %d\r\n", (Y.value[0] & 1));
//         // printf("n = %d\r\n", n);

//         // Do if operations here to avoid multiplication operation
//         if (rshift_uint32x3(X, i).value[2] & 1){
//             print_uint32x3("T_low", T_low);
//             print_uint32x3("T_high", T_high);
//             print_uint32x3("Y", Y);

//             T_low = add_uint32x3(T_low, Y);

//             // T_low smaller than Y means there is carry
//             if (cmp_uint32x3(T_low, Y)){
//                 // print_uint32x3("T", T);
//                 // print_uint32x3("M", M);
                
//                 // add one to T_high
//                 T_high = add_uint32x3(T_high, ONE);
//             }

//             print_uint32x3("Result_low", T_low);
//             print_uint32x3("Result_high", T_high);
//         }

//         if (n){
//             print_uint32x3("T_low", T_low);
//             print_uint32x3("T_high", T_high);
//             print_uint32x3("M", M);

//             T_low = add_uint32x3(T_low, Y);

//             // T_low smaller than Y means there is carry
//             if (cmp_uint32x3(T_low, M)){
//                 // print_uint32x3("T", T);
//                 // print_uint32x3("M", M);
                
//                 // add one to T_high
//                 T_high = add_uint32x3(T_high, ONE);
//             }

//             print_uint32x3("Result_low", T_low);
//             print_uint32x3("Result_high", T_high);
//         }
//         T_low = rshift_uint32x3(T, 1);

//         // // keep t under M to prevent overflow
//         // if (!cmp_uint32x3(T, M)){
//         //     // print_uint32x3("T", T);
//         //     // print_uint32x3("M", M);
            
//         //     T = sub_uint32x3(T, M);
//         //     // print_uint32x3("Result", T);
//         // }
//     }

//     if (!cmp_uint32x3(T, M)){
//         // print_uint32x3("T", T);
//         // print_uint32x3("M", M);
        
//         T = sub_uint32x3(T, M);
//         // print_uint32x3("Result", T);
//     }

//     // print_uint32x3("T", T);
//     // print_uint32x3("M", M);
//     // printf("%d\n", !cmp_uint32x3(T, M));
    
//     return T;
// }

// Code written based of MMM pseudocode from slides

// Observation: RSA does not use negative X, Y and M, thus unsigned
// should be used to maximize number of representable positive integers
// changing to unsigned long long int should be done to allow 95 bit
// integers
int modular_multiplication(int X, int Y, int M, int numBits)
{
    // Observation: Common variables that are frequently used should be
    // stored in registers
    long int T = 0;

    // Find m, number of bits in M
    int m = numBits;

    // Observation: Loop unrolling can be performed, especially since
    // only 2 operations in the loop, and the second operation is dependent
    // on first.
    for (int i = 0; i < m; i++)
    {
        // Observation: Repeated calculation of X(i), can store result
        // in a register.

        // Observation: Multiplication is expensive, but since
        // multiplication is not going to be with a direct power of 2,
        // difficult to identify how to optimize with bit operations.

        // Observation: There are operations in T that is not dependent
        // on n, such as (T + (((x >> i) & 1) * y)), ensure that
        // compiler allows this to be run concurrently.
        int n = (T & 1) ^ (((X >> i) & 1) & (Y & 1));
        // printf("T(0) = %d\r\n", (T & 1));
        // printf("X(i) = %d\r\n", ((X >> i) & 1));
        // printf("Y(0) = %d\r\n", (Y & 1));
        // printf("n = %d\r\n", n);

        T = (T + ((X >> i) & 1) * Y + (n * M)) >> 1;
    }
    if (T >= M)
        T = T - M;
    return T;
}

uint32x3_t encrypt(uint32x3_t plain_t, uint32x3_t E, uint32x3_t N, int numBits, uint32x3_t r2m){
    return modular_exponentiation_mont_32x3(plain_t, E, N, numBits, r2m);
}

uint32x3_t decrypt(uint32x3_t cipher_t, uint32x3_t D, uint32x3_t N, int numBits, uint32x3_t r2m){
    return modular_exponentiation_mont_32x3(cipher_t, D, N, numBits, r2m);
}

int main(int argc, char *argv[])
{
    // 48 bit Keys
    // n='a362fc7f41e5' e='000000010001' d='1db8365798ed'

    uint32x3_t plain_t = {0, 0x00005000, 0x73000001}; // 0000500073000001
    uint32x3_t N = {0, 0x0000a362, 0xfc7f41e5}; // 0000bc046e91ae5f
    uint32x3_t E = {0, 0, 0x00010001};
    uint32x3_t D = {0, 0x00001db8, 0x365798ed};
    uint32x3_t r2m_95_2 = {0, 0x0000265b, 0xa323e7d0};

    printf("Encrypting 48 bit\n");
    print_uint32x3("Plain Text", plain_t);
    print_uint32x3("PQ", N);
    print_uint32x3("E", E);
    print_uint32x3("D", D);
    uint32x3_t cipher_t = encrypt(plain_t, E, N, 48, r2m_95_2);
    // printf("Expected Cipher Text = 0x51d6eef4c6ad\n");
    print_uint32x3("Encrypted Cipher Text", cipher_t);
    
    printf("Decrypting 48 bit\n");
    uint32x3_t plain_t_res = decrypt(cipher_t, D, N, 48, r2m_95_2);
    print_uint32x3("Decrypted Plain Text", plain_t_res);
    printf("\n");

    // 95 bit Keys 
    // n'74AE684379222DF5CAA0445B' e'3EBB554CBEB561092B0B2B5F' d'76964AF8A1660D337A2F071F'
    uint32x3_t plain_t_95 = {0x37E4358A, 0x02B228EF, 0xBFFAC88B};
    uint32x3_t N_95 = {0x74AE6843, 0x79222DF5, 0xCAA0445B};
    uint32x3_t E_95 = {0x3EBB554C, 0xBEB56109, 0x2B0B2B5F};
    uint32x3_t D_95 = {0x76964AF8, 0xA1660D33, 0x7A2F071F};
    uint32x3_t r2m_95_2_95 = {0x662F7452, 0xF2B207B4, 0xDF150A2D};

    printf("Encrypting 95 bit\n");
    print_uint32x3("Plain Text", plain_t_95);
    print_uint32x3("PQ", N_95);
    print_uint32x3("E", E_95);
    print_uint32x3("D", D_95);
    // printf("Expected Cipher Text = 0x5E540B6F3B7B69CC81648395\n");
    uint32x3_t cipher_t_95 = encrypt(plain_t_95, E_95, N_95, 95, r2m_95_2_95);
    print_uint32x3("Encrypted Cipher Text", cipher_t_95);

    printf("Decrypting 95 bit\n");
    uint32x3_t plain_t_res_95 = decrypt(cipher_t_95, D_95, N_95, 95, r2m_95_2_95);
    print_uint32x3("Decrypted Plain Text", plain_t_res_95);
    printf("\n");

    // Test Case 2 - 96 Bit
    // n'a0d552aefb090ec4601429b7' e'000000000000000000010001' d'54a24d23655514b500278929'
    uint32x3_t plain_t_95_2 = {0x37E4358A, 0x02B228EF, 0xBFFAC88B};
    uint32x3_t N_95_2 = {0xa0d552ae, 0xfb090ec4, 0x601429b7};
    uint32x3_t E_95_2 = {0x00000000, 0x00000000, 0x00010001};
    uint32x3_t D_95_2 = {0x54a24d23,0x655514b5,0x00278929};
    uint32x3_t r2m_95_2_95_2 = {0x599147d0, 0x0a1404f1 ,0xb605d62c};

    printf("Encrypting 96 bit\n");
    print_uint32x3("Plain Text", plain_t_95_2);
    print_uint32x3("PQ", N_95_2);
    print_uint32x3("E", E_95_2);
    print_uint32x3("D", D_95_2);
    uint32x3_t cipher_t_95_2 = encrypt(plain_t_95_2, E_95_2, N_95_2, 96, r2m_95_2_95_2);
    print_uint32x3("Encrypted Cipher Text", cipher_t_95_2);

    printf("Decrypting 96 bit\n");
    uint32x3_t plain_t_res_95_2 = decrypt(cipher_t_95_2, D_95_2, N_95_2, 96, r2m_95_2_95_2);
    print_uint32x3("Decrypted Plain Text", plain_t_res_95_2);


    return 0;
}