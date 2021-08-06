#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <inttypes.h>

// uint32x3_t
typedef struct uint32x3_t {
    uint32_t value[3];
} uint32x3_t;

// uint32x3_t operations
uint32x3_t add_uint32x3(uint32x3_t, uint32x3_t);
uint32x3_t sub_uint32x3(uint32x3_t, uint32x3_t);
uint32_t cmp_uint32x3(uint32x3_t, uint32x3_t);
void print_uint32x3(char*, uint32x3_t);
// uint32x3_t mul(uint32x3_t, uint32x3_t);
// uint32x3_t div(uint32x3_t, uint32x3_t);
// uint32x3_t and(uint32x3_t, uint32x3_t);
// uint32x3_t or(uint32x3_t, uint32x3_t);
// uint32x3_t xor(uint32x3_t, uint32x3_t);
// uint32x3_t lshift(uint32x3_t, int); // not used
uint32x3_t rshift_uint32x3(uint32x3_t, int);

// uint32x3_t add_uint32x3(uint32x3_t x, uint32x3_t y)
// {
//     uint32x3_t result = {0};
//     unsigned int carry = 0;
//     // int i = sizeof(x.value)/sizeof(x.value[0]);
//     /* Start from LSB */
//     // while(i--)
//     for (int i = 2; i != 0; i--)
//     {
//         uint64_t tmp = (uint64_t)x.value[i] + y.value[i] + carry;    
//         result.value[i] = (uint32_t)tmp;
//         /* Remember the carry */
//         carry = tmp >> 32;
//     }
//     return result;
// }

// uint32x3_t add_uint32x3(uint32x3_t x, uint32x3_t y)
// {
//     uint32x3_t result = {0};
//     unsigned int carry = 0;

//     // int i = sizeof(x.value)/sizeof(x.value[0]);
//     /* Start from LSB */
//     // while(i--)
//     for (int i = 2; i != 0; i--)
//     {
//         uint64_t tmp = (uint64_t)x.value[i] + y.value[i] + carry;    
//         result.value[i] = (uint32_t)tmp;
//         /* Remember the carry */
//         carry = tmp >> 32;
//     }
//     return result;
// }

// uint32x3_t add_uint32x3(uint32x3_t x, uint32x3_t y)
// {
//     uint32x3_t result = {0};
//     unsigned int carry = 0;

//     // int i = sizeof(x.value)/sizeof(x.value[0]);
//     /* Start from LSB */
//     // while(i--)
//     for (int i = 2; i != 0; i--)
//     {
//         uint64_t tmp = (uint64_t)x.value[i] + y.value[i] + carry;    
//         result.value[i] = (uint32_t)tmp;
//         /* Remember the carry */
//         carry = tmp >> 32;
//     }
//     return result;
// }

// Assume x >= y
uint32x3_t sub_uint32x3(uint32x3_t x, uint32x3_t y)
{
    uint32x3_t result = {0};
    unsigned int carry = 0;

    result.value[2] = x.value[2] - y.value[2];
    result.value[1] = x.value[1] - y.value[1];
    result.value[0] = x.value[0] - y.value[0];

    // check for underflow of lowest 32 bits, sub overflow to mid
    if (result.value[2] > x.value[2]){
        printf("sub mid\n");
        --result.value[1];
    }

    // check for underflow of mid 32 bits, sub underflow to high
    if (result.value[1] > x.value[1]){
        printf("sub high\n");
        --result.value[0];
    }

    return result;
}

uint32x3_t add_uint32x3(uint32x3_t x, uint32x3_t y)
{
    uint32x3_t result = {0};
    unsigned int carry = 0;

    result.value[2] = x.value[2] + y.value[2];
    result.value[1] = x.value[1] + y.value[1];
    result.value[0] = x.value[0] + y.value[0];

    // check for overflow of lowest 32 bits, add carry to mid
    if (result.value[2] < x.value[2]){
        printf("add mid\n");
        ++result.value[1];
    }

    // check for overflow of mid 32 bits, add carry to high
    if (result.value[1] < x.value[1]){
        printf("add high\n");
        ++result.value[0];
    }

    return result;
}

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


// https://en.wikipedia.org/wiki/Modular_exponentiation
// Modular Exponentiation based on slides and also pseudocode on Wikipedia.
int modular_exponentiation(int b, int e, int m)
{
    int result = 1;

    if (1 & e) // if e is odd
        result = b;
    while (e > 0)
    { // while e > 0
        e >>= 1;                       // e = e/2
        b = (b * b) % m;               // b = b^2 % m
        if (e & 1)                     // if e is odd
            result = (result * b) % m; // result = result * b % m
    }
    return result;
}

// Code written based of MMM pseudocode from slides

// Observation: RSA does not use negative X, Y and M, thus unsigned
// should be used to maximize number of representable positive integers
// changing to unsigned long long int should be done to allow 95 bit
// integers
int modular_multiplication(int X, int Y, int M)
{
    // Observation: Common variables that are frequently used should be
    // stored in registers
    int T = 0;

    // Find m, number of bits in M
    int m = 0;
    int temp = M;
    while (temp)
    {
        m++;
        temp >>= 1;
    }
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
        printf("X>>i & 1 = %i\n", (X >> i) & 1);
        printf("n = %i\n", n);
        printf("n * M = %i\n", (n * M));
        T = (T + ((X >> i) & 1) * Y + (n * M)) >> 1;
    }
    if (T >= M)
        T = T - M;
    return T;
}

int main(int argc, char *argv[])
{
    // Basic Modular Multiplication Test from Slides
    int X = 17;
    int Y = 22;
    int M = 23;

    int Z = modular_multiplication(X, Y, M);
    printf("%d\n", Z); // Answer should be 16

    // Basic Modular Exponentiation Test from Slides
    int base = 4;
    int exp = 13;
    int mod = 497;

    int modulo = modular_exponentiation(base, exp, mod);
    printf("%d\n", modulo); // Answer should be 445

    // Simple E
    // P = 221695237201051
    // Q = 162886253482817
    // N = 36111106602663634391602840667
    // E = 17
    // D = 59477116757327705569596493553 
    // x = 28

    // 95 bit E
    // P = 221695237201051 // 48 bit
    // Q = 162886253482817 // 48 bit
    // N = 36111106602663634391602840667 // P*Q, 48 bit * 48 bit = 95 bit
    // E = 19414542554036919968371256159 // prime, therefore is relatively prime with (P-1)(Q-1)
    // D = 36700924073403172721919985439 // 95 bit
    // x = 19731648216590892426383796091

    // 95 bit keys
    const uint32_t N[3] = {0x74AE6843, 0x79222DF5, 0xCAA0445B};
    const uint32_t E[3] = {0x3EBB554C, 0xBEB56109, 0x2B0B2B5F};
    const uint32_t D[3] = {0x76964AF8, 0xA1660D33, 0x7A2F071F};

    // encrypt plaintext 55
    // cipher text expected result 5740687887086918635830255485
    // decrypt expected result 55

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
    uint32x3_t rs_r = rshift_uint32x3(rs_a, 2);
    print_uint32x3("rs_r", rs_r); //91A2B3C0091A2B3CC3B2A19
    return 0;
}