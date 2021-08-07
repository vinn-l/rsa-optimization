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
        result.value[2] = result.value[0];
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
    uint32x3_t T = {0};
    int m = numBits;
    int carry = 0;

    for (int i = 0; i < m; i++)
    {
        uint32_t n = (T.value[2] & 1) ^ ((rshift_uint32x3(X, i).value[2] & 1) & (Y.value[2] & 1));
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

            T = add_uint32x3(T, Y);

            // print_uint32x3("T_add", T);

            // // T smaller than Y means overflow
            if (cmp_uint32x3(T, Y)){
                printf("Overflow\n");
                carry += 1;
            }

            // print_uint32x3("Result", T);
        }

        if (n){
            // print_uint32x3("T", T);
            // print_uint32x3("M", M);

            T = add_uint32x3(T, M);

            // print_uint32x3("T_add", T);

            // // T smaller than M means overflow
            if (cmp_uint32x3(T, M)){
                printf("Overflow\n");
                carry += 1;
                // printf("%d\n", carry);

                if (carry == 2){
                    printf("carry is 2\n");
                }
            }

            // print_uint32x3("Result", T);
        }

        T = rshift_uint32x3(T, 1);
        
        // if carry is set
        if (carry){
            print_uint32x3("T_shiftcarry", T);
            T.value[0] += (carry << (31));
            print_uint32x3("T_shiftcarry", T);
            carry = 0;
        }
    }

    // print_uint32x3("T", T);
    // print_uint32x3("M", M);

    if (!cmp_uint32x3(T, M)){
        // print_uint32x3("T", T);
        // print_uint32x3("M", M);
        T = sub_uint32x3(T, M);
        // print_uint32x3("T_sub", T);
    }

    // print_uint32x3("T", T);
    // print_uint32x3("M", M);
    // printf("%d\n", !cmp_uint32x3(T, M));
    
    return T;
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

int main(int argc, char *argv[])
{
    // 1. Basic Modular Multiplication Test from Slides
    int X = 17;
    int Y = 22;
    int M = 23;

    int Z = modular_multiplication(X, Y, M, count_bits(M));
    printf("Expected: 16\n"); // Answer should be 16
    printf("Z = %d\n", Z); // Answer should be 16

    // 2. Basic Modular Multiplication Test from Slides for 95 bits
    uint32x3_t X_95 = {0x00000000, 0x00000000, 17};
    uint32x3_t Y_95 = {0x00000000, 0x00000000, 22};
    uint32x3_t M_95 = {0x00000000, 0x00000000, 23};

    uint32x3_t Z_95 = modular_multiplication_32x3(X_95, Y_95, M_95, 5);
    printf("Expected: 0x10\n"); // Answer should be 16 or 0x10
    print_uint32x3("Z_95", Z_95);

    // 3. Basic Modular Exponentiation Test from Slides
    int base = 4;
    int exp = 13;
    int mod = 497;

    int modulo = modular_exponentiation(base, exp, mod);
    printf("Expected: 445\n"); // Answer should be 445
    printf("%d\n", modulo); // Answer should be 445

    // 4. Montgomery Modular Exponentiation Test from Slides
    
    printf("num bits: %d\n", count_bits(mod));
    modulo = modular_exponentiation_mont(base, exp, mod, 9);
    printf("Expected: 445\n"); // Answer should be 445
    printf("%d\n", modulo); // Answer should be 445

    // 4. Montgomery Modular Exponentiation Test from Slides for 95 bits
    uint32x3_t base_95 = {0x00000000, 0x00000000, 4};
    uint32x3_t exp_95 = {0x00000000, 0x00000000, 13};
    uint32x3_t mod_95 = {0x00000000, 0x00000000, 497};
    uint32x3_t r2m_95 = {0,0,225};

    uint32x3_t modulo_95 = modular_exponentiation_mont_32x3(base_95, exp_95, mod_95, 9, r2m_95);
    printf("Expected: 0x1BD\n"); // Answer should be 445 or 0x1BD
    print_uint32x3("modulo_95", modulo_95);

    // int
    int P_s = 55;
    int N_s = 3233;
    int E_s = 17;
    int D_s = 2753;

    // int cipher_s = modular_exponentiation(P_s, E_s, N_s);
    int cipher_s = modular_exponentiation_mont(P_s, E_s, N_s, 12);
    printf("Expected: 2653\n"); // Answer should be 2653
    printf("cipher_s = %i\n", cipher_s);
    // int plain_s = modular_exponentiation(cipher_s, D_s, N_s);
    int plain_s = modular_exponentiation_mont(cipher_s, D_s, N_s, 12);
    printf("Expected: 55\n"); // Answer should be 55
    printf("plain_s = %i\n", plain_s);

    // Simple E Test Case
    // P = 221695237201051
    // Q = 162886253482817
    // N = 36111106602663634391602840667
    // E = 17
    // D = 59477116757327705569596493553 
    // x = 28

    // 95 bit E Test Case
    // P = 221695237201051 // 48 bit
    // Q = 162886253482817 // 48 bit
    // N = 36111106602663634391602840667 // P*Q, 48 bit * 48 bit = 95 bit
    // E = 19414542554036919968371256159 // prime, therefore is relatively prime with (P-1)(Q-1)
    // D = 36700924073403172721919985439 // 95 bit
    // x = 19731648216590892426383796091

    // 95 bit Keys 
    // uint32x3_t plain_t = {0x37E4358A, 0x02B228EF, 0xBFFAC88B};
    uint32x3_t plain_t = {0, 0x00005000, 0x73000001}; // 0000500073000001
    // uint32x3_t plain_t = {0, 0x00000000, 0x0000080501};
    // uint32x3_t N = {0x74AE6843, 0x79222DF5, 0xCAA0445B};
    uint32x3_t N = {0, 0x0000bc04, 0x6e91ae5f}; // 0000bc046e91ae5f
    // uint32x3_t N = {0, 0, 0x00a73911};
    // uint32x3_t E = {0x3EBB554C, 0xBEB56109, 0x2B0B2B5F};
    uint32x3_t E = {0, 0, 0x00010001}; // 00010001
    // uint32x3_t D = {0x76964AF8, 0xA1660D33, 0x7A2F071F};
    uint32x3_t D = {0x76964AF8, 0xA1660D33, 0x004a051d}; // 76964AF8A1660D33004a051d
    uint32x3_t r2m_95_2 = {0, 0x0000507f, 0xb204bae6}; // verified correct for 48 bit
    // uint32x3_t r2m_95_2 = {0x662F7452, 0xF2B207B4, 0xDF150A2D};
    // uint32x3_t P = {0x00000000, 0x00000000, 55};
    // uint32x3_t N = {0x00000000, 0x00000000, 3233};
    // uint32x3_t E = {0x00000000, 0x00000000, 17};
    // uint32x3_t D = {0x76964AF8, 0xA1660D33, 2753};

    // encrypt plaintext 55
    // cipher text expected result 5740687887086918635830255485
    // decrypt expected result 55

    uint32x3_t cipher_t = modular_exponentiation_mont_32x3(plain_t, E, N, 48, r2m_95_2);
    // uint32x3_t cipher_t = modular_exponentiation_mont_32x3(plain_t, E, N, 95, r2m_95_2);
    // printf("Expected: 0x5E540B6F3B7B69CC81648395\n"); // Answer should be 29193194689960104856100570005, or 0x5E540B6F3B7B69CC81648395
    printf("Expected: 0x51d6eef4c6ad\n"); // Answer should be 29193194689960104856100570005, or 0x5E540B6F3B7B69CC81648395
    print_uint32x3("cipher_t", cipher_t);
    uint32x3_t plain_t_res = modular_exponentiation_mont_32x3(cipher_t, D, N, 95, r2m_95_2);
    printf("Expected: 0x37E4358A02B228EFBFFAC88B\n"); // Answer should be 17297563458314651238923946123, or 0x37E4358A02B228EFBFFAC88B
    print_uint32x3("plain_t_res", plain_t_res);
    // encrypt plaintext 17297563458314651238923946123
    // cipher text expected result 29193194689960104856100570005
    // decrypt expected result 36111106602663634391602840667

    // uint64_t a = 11446744073709551615ULL;
    // uint64_t b = 1223472026853735807ULL;

    // uint64_t c = a + b;
    // printf("uint_64");
    // printf("%" PRIu64 "\n", c);

    // Test addition 32x3
    uint32x3_t x = {0x0FFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF};
    uint32x3_t y = {0x00, 0x00, 0x01};
    uint32x3_t r = add_uint32x3(x, y);
    print_uint32x3("x", x);
    print_uint32x3("y", y);
    print_uint32x3("result", r);

    // T = a967651f93186f4006a0bcd3
    // M = 3adac9fab325ff4838b1e2df
    uint32x3_t x_2 = {0xa967651f, 0xffffffff, 0xf6a0bcd3};
    uint32x3_t y_2 = {0x3adac9fa, 0xffffffff, 0x38b1e2df};
    uint32x3_t x_2_1 = add_uint32x3(x_2, y_2);
    // uint32x3_t x_2_2 = add_uint32x3_2(x_2, y_2);
    print_uint32x3("x_2", x_2);
    print_uint32x3("y_2", y_2);
    print_uint32x3("result", x_2_1);
    // print_uint32x3("result_2", x_2_2);

    // Test subtraction 32x3
    uint32x3_t sub_a = {0x4FFFFFFF, 0x9FFFFFFF, 0x5FFFFFFF};
    uint32x3_t sub_b = {0x0FFFFFFF, 0x9FFFFFFF, 0x6FFFFFFF};
    uint32x3_t sub_r = sub_uint32x3(sub_a, sub_b);
    print_uint32x3("sub_a", sub_a);
    print_uint32x3("sub_b", sub_b);
    print_uint32x3("sub_r", sub_r);

    // Test compare 32x3
    uint32x3_t cmp_a = {0x4FFFFFFF, 0x4FFFFFFF, 0x5FFFFFFF};
    uint32x3_t cmp_b = {0x0FFFFFFF, 0x9FFFFFFF, 0x6FFFFFFF};
    uint32_t cmp_r = cmp_uint32x3(cmp_a, cmp_b); // 0
    uint32_t cmp_rr = cmp_uint32x3(cmp_b, cmp_a); // 1
    uint32_t cmp_rrr = cmp_uint32x3(cmp_a, cmp_a); // 0
    printf("cmp_r = %" PRIu32 "\ncmp_rr = %" PRIu32 "\ncmp_rrr = %" PRIu32 "\n", cmp_r, cmp_rr, cmp_rrr);

    // Test rshift
    uint32x3_t rs_a = {0x12345678, 0x01234567, 0x98765432};
    uint32x3_t rs_r = rshift_uint32x3(rs_a, 1);
    print_uint32x3("rs_r", rs_r); //91A2B3C0091A2B3CC3B2A19
    return 0;
}